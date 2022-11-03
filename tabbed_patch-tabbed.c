--- tabbed.c.orig	2022-01-01 22:30:00 UTC
+++ tabbed.c
@@ -934,8 +934,8 @@ setup(void) {
 	/* init appearance */
 	wx = 0;
 	wy = 0;
-	ww = 800;
-	wh = 600;
+	ww = 564;
+	wh = 379;
 	isfixed = 0;
 
 	if(geometry) {
@@ -997,6 +997,11 @@ setup(void) {
 		size_hint->min_width = size_hint->max_width = ww;
 		size_hint->min_height = size_hint->max_height = wh;
 	}
+	size_hint->flags |= PResizeInc | PBaseSize;
+	size_hint->width_inc = 7;
+	size_hint->height_inc = 15;
+	size_hint->base_width = 2 + 2;
+	size_hint->base_height = bh + 2 + 2;
 	XSetWMProperties(dpy, win, NULL, NULL, NULL, 0, size_hint, NULL, NULL);
 	XFree(size_hint);
 
