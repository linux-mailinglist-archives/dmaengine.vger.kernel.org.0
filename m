Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9DE72CA8E
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jun 2023 17:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239720AbjFLPpH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 12 Jun 2023 11:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239689AbjFLPpF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 12 Jun 2023 11:45:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D09210CE;
        Mon, 12 Jun 2023 08:45:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E84C962B10;
        Mon, 12 Jun 2023 15:45:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CF72C433D2;
        Mon, 12 Jun 2023 15:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686584702;
        bh=i8KTAL9m8czF59/PWA43ufGF+FzGsWZsS4YZqCVtdKk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S6SCCwEkUvsAE44g1h3nEDQvyPPbLi9tRWYfi7bXehLj56bfQ32rk8JZJk89wj1KH
         wbSgiqPPh527cc4rsW/DFf21XHZC1DgpLsktZsa6oeyHkHf49wYWp20NWb+pX3Ivf8
         7UX+5YYHNwBwokPzVWADs1YDGLcSKPZcwRgqNknA=
Date:   Mon, 12 Jun 2023 17:44:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     torvalds@linux-foundation.org, keescook@chromium.org,
        pbonzini@redhat.com, masahiroy@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, nicolas@fjasle.eu,
        catalin.marinas@arm.com, will@kernel.org, vkoul@kernel.org,
        trix@redhat.com, ojeda@kernel.org, mingo@redhat.com,
        longman@redhat.com, boqun.feng@gmail.com, dennis@kernel.org,
        tj@kernel.org, cl@linux.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        rientjes@google.com, vbabka@suse.cz, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, apw@canonical.com, joe@perches.com,
        dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
        john.johansen@canonical.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        llvm@lists.linux.dev, linux-perf-users@vger.kernel.org,
        rcu@vger.kernel.org, linux-security-module@vger.kernel.org,
        tglx@linutronix.de, ravi.bangoria@amd.com, error27@gmail.com,
        luc.vanoostenryck@gmail.com
Subject: Re: [PATCH v3 46/57] perf: Simplify pmu_dev_alloc()
Message-ID: <2023061217-mutable-curry-c2ac@gregkh>
References: <20230612090713.652690195@infradead.org>
 <20230612093540.850386350@infradead.org>
 <20230612094400.GG4253@hirez.programming.kicks-ass.net>
 <2023061226-grumpily-entire-f06a@gregkh>
 <20230612141322.GA83892@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612141322.GA83892@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Jun 12, 2023 at 04:13:22PM +0200, Peter Zijlstra wrote:
> > Mind if I try this series to convert a more "normal" driver to see how
> > it works with that?  That's going to be the true test, see if the
> > changes make sense to someone who doesn't really know the internals of
> > the driver core like this...
> 
> Not at all, feel tree to have a go at that. I picked code I was familiar
> with, but it would ofc. be good to have others give it a spin too.

Ok, here's an attempt to clean up misc.c a bit.  It does two things,
adds a guard for the global misc_mtx mutex when used (sometimes, it's
not always paired with a release.)

Then in the last part of the file, I abuse the DEFINE_FREE() to handle a
special case of removing a proc file if things go bad (and add a
DEFINE_FREE() for class_destroy(), which should go into
include/device/class.h.

I've only test-built it, but is this the proper use of DEFINE_FREE()?
There wasn't much documentation :)

To be fair the end-result of misc_init() is much nicer and cleaner and
"obviously correct", which is good, even with the crazy proc file mess
in it.  So I like the idea overall, need to figure out when to use
DEFINE_CLASS() vs. DEFINE_FREE(), that isn't obvious to me.

Also, you can't put a DEFINE_FREE() within a function declaration, which
I guess makes sense, but the build warning is very odd when you attempt
it, mentioning an "invalid storage class".  Is that supposed to be able
to work?

thanks,

greg k-h


---
 drivers/char/misc.c | 69 +++++++++++++++++----------------------------
 1 file changed, 26 insertions(+), 43 deletions(-)

diff --git a/drivers/char/misc.c b/drivers/char/misc.c
index 1c44c29a666e..a203b17a2b82 100644
--- a/drivers/char/misc.c
+++ b/drivers/char/misc.c
@@ -123,10 +123,9 @@ static int misc_open(struct inode *inode, struct file *file)
 {
 	int minor = iminor(inode);
 	struct miscdevice *c = NULL, *iter;
-	int err = -ENODEV;
 	const struct file_operations *new_fops = NULL;
 
-	mutex_lock(&misc_mtx);
+	guard(mutex)(&misc_mtx);
 
 	list_for_each_entry(iter, &misc_list, list) {
 		if (iter->minor != minor)
@@ -149,7 +148,7 @@ static int misc_open(struct inode *inode, struct file *file)
 			break;
 		}
 		if (!new_fops)
-			goto fail;
+			return -ENODEV;
 	}
 
 	/*
@@ -159,13 +158,11 @@ static int misc_open(struct inode *inode, struct file *file)
 	 */
 	file->private_data = c;
 
-	err = 0;
 	replace_fops(file, new_fops);
 	if (file->f_op->open)
-		err = file->f_op->open(inode, file);
-fail:
-	mutex_unlock(&misc_mtx);
-	return err;
+		return file->f_op->open(inode, file);
+
+	return 0;
 }
 
 static struct class *misc_class;
@@ -197,29 +194,24 @@ static const struct file_operations misc_fops = {
 int misc_register(struct miscdevice *misc)
 {
 	dev_t dev;
-	int err = 0;
 	bool is_dynamic = (misc->minor == MISC_DYNAMIC_MINOR);
 
 	INIT_LIST_HEAD(&misc->list);
 
-	mutex_lock(&misc_mtx);
+	guard(mutex)(&misc_mtx);
 
 	if (is_dynamic) {
 		int i = misc_minor_alloc();
 
-		if (i < 0) {
-			err = -EBUSY;
-			goto out;
-		}
+		if (i < 0)
+			return -EBUSY;
 		misc->minor = i;
 	} else {
 		struct miscdevice *c;
 
 		list_for_each_entry(c, &misc_list, list) {
-			if (c->minor == misc->minor) {
-				err = -EBUSY;
-				goto out;
-			}
+			if (c->minor == misc->minor)
+				return -EBUSY;
 		}
 	}
 
@@ -233,8 +225,7 @@ int misc_register(struct miscdevice *misc)
 			misc_minor_free(misc->minor);
 			misc->minor = MISC_DYNAMIC_MINOR;
 		}
-		err = PTR_ERR(misc->this_device);
-		goto out;
+		return PTR_ERR(misc->this_device);
 	}
 
 	/*
@@ -242,9 +233,7 @@ int misc_register(struct miscdevice *misc)
 	 * earlier defaults
 	 */
 	list_add(&misc->list, &misc_list);
- out:
-	mutex_unlock(&misc_mtx);
-	return err;
+	return 0;
 }
 EXPORT_SYMBOL(misc_register);
 
@@ -261,11 +250,10 @@ void misc_deregister(struct miscdevice *misc)
 	if (WARN_ON(list_empty(&misc->list)))
 		return;
 
-	mutex_lock(&misc_mtx);
+	guard(mutex)(&misc_mtx);
 	list_del(&misc->list);
 	device_destroy(misc_class, MKDEV(MISC_MAJOR, misc->minor));
 	misc_minor_free(misc->minor);
-	mutex_unlock(&misc_mtx);
 }
 EXPORT_SYMBOL(misc_deregister);
 
@@ -280,29 +268,24 @@ static char *misc_devnode(const struct device *dev, umode_t *mode)
 	return NULL;
 }
 
+DEFINE_FREE(class_destroy, struct class *, if (_T) class_destroy(_T));
+DEFINE_FREE(remove_proc, struct proc_dir_entry *, if (_T) remove_proc_entry("misc", NULL));
 static int __init misc_init(void)
 {
-	int err;
-	struct proc_dir_entry *ret;
+	struct proc_dir_entry *ret __free(remove_proc) = proc_create_seq("misc", 0, NULL, &misc_seq_ops);
+	struct class *c __free(class_destroy) = class_create("misc");
 
-	ret = proc_create_seq("misc", 0, NULL, &misc_seq_ops);
-	misc_class = class_create("misc");
-	err = PTR_ERR(misc_class);
-	if (IS_ERR(misc_class))
-		goto fail_remove;
+	if (IS_ERR(c))
+		return PTR_ERR(c);
 
-	err = -EIO;
 	if (register_chrdev(MISC_MAJOR, "misc", &misc_fops))
-		goto fail_printk;
-	misc_class->devnode = misc_devnode;
-	return 0;
+		return -EIO;
 
-fail_printk:
-	pr_err("unable to get major %d for misc devices\n", MISC_MAJOR);
-	class_destroy(misc_class);
-fail_remove:
-	if (ret)
-		remove_proc_entry("misc", NULL);
-	return err;
+	c->devnode = misc_devnode;
+
+	misc_class = no_free_ptr(c);
+	no_free_ptr(ret);
+
+	return 0;
 }
 subsys_initcall(misc_init);
-- 
2.41.0

