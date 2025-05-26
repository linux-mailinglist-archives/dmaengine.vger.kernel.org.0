Return-Path: <dmaengine+bounces-5269-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E98AC3CAC
	for <lists+dmaengine@lfdr.de>; Mon, 26 May 2025 11:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C43FD3A94A5
	for <lists+dmaengine@lfdr.de>; Mon, 26 May 2025 09:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298FB1F1522;
	Mon, 26 May 2025 09:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Nbe/WxBo"
X-Original-To: dmaengine@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0493572600
	for <dmaengine@vger.kernel.org>; Mon, 26 May 2025 09:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748251594; cv=none; b=sU0e9THWEs/7zloZIB+OQFkRdpXFHRBXLcwnH4KBBbo4xhAmkBgv47zI5VCFZDUtsUn4mANzUHhTssYvNrzYxAYuBbpLPQrdHsdlwmrx440+mSJ740hP8PBR9Vw+72wakjA5fowXbzvIjq18c5A1W/cr+S+TFzJAC36u92TTb7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748251594; c=relaxed/simple;
	bh=lVbzhPaz+7K5lfVz2nfTAwtqcnMAzfpf5XmOESZX8AA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g+kfYCo6vmqugRgIASqw1Xht5jUIhQsFvONr/wkU7wtyh1wFPQylH7hyQB3qQFdQcjY0kiG9Ee+dv9rZF0gUeqMdOgYL9pQzeo/p0jZUMC074qOeY2xVx6jdaw2Kl6rSoD3SlRkuQ8f7KiAEUYOMIguQmSrEzj3mso+fhEayQ6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Nbe/WxBo; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1748251580; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=NBjoKyfbHLm98pOCN1ffAGyNCZJ/v1iV+H9uM+CNNpc=;
	b=Nbe/WxBodevO+0+iPrNO4YtiSpcCYvMM/R9eCL5YIDlvlVgEFaCCcpMdkwSqq1JtOp9qZBgF1KPN+oGTo05l3zUi+2TCqjDVAVbyEds5rqJ5akChwj4LqB2dMvrGIg4EMhSNpB8ObzXFsD/FhRpYkdpDInTiPTOu60QkRNiRD6U=
Received: from 30.246.160.208(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Wbnl82g_1748251579 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 26 May 2025 17:26:20 +0800
Message-ID: <08b98863-4700-40a6-b8a9-1ed305a57d8e@linux.alibaba.com>
Date: Mon, 26 May 2025 17:26:17 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] dmaengine: idxd: fix memory leak in error handling
 path of idxd_setup_wqs
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Dave Jiang <dave.jiang@intel.com>,
 "Colin King (gmail)" <colin.i.king@gmail.com>
Cc: dmaengine@vger.kernel.org
References: <aDQt3_rZjX-VuHJW@stanley.mountain>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <aDQt3_rZjX-VuHJW@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/5/26 17:01, Dan Carpenter 写道:
> Hello Shuai Xue,
> 
> Commit 3fd2f4bc010c ("dmaengine: idxd: fix memory leak in error
> handling path of idxd_setup_wqs") from Apr 4, 2025 (linux-next),
> leads to the following Smatch static checker warning:
> 
> 	drivers/dma/idxd/init.c:246 idxd_setup_wqs()
> 	error: uninitialized symbol 'conf_dev'.
> 
> drivers/dma/idxd/init.c
>      177 static int idxd_setup_wqs(struct idxd_device *idxd)
>      178 {
>      179         struct device *dev = &idxd->pdev->dev;
>      180         struct idxd_wq *wq;
>      181         struct device *conf_dev;
>      182         int i, rc;
>      183
>      184         idxd->wqs = kcalloc_node(idxd->max_wqs, sizeof(struct idxd_wq *),
>      185                                  GFP_KERNEL, dev_to_node(dev));
>      186         if (!idxd->wqs)
>      187                 return -ENOMEM;
>      188
>      189         idxd->wq_enable_map = bitmap_zalloc_node(idxd->max_wqs, GFP_KERNEL, dev_to_node(dev));
>      190         if (!idxd->wq_enable_map) {
>      191                 rc = -ENOMEM;
>      192                 goto err_bitmap;
>      193         }
>      194
>      195         for (i = 0; i < idxd->max_wqs; i++) {
>      196                 wq = kzalloc_node(sizeof(*wq), GFP_KERNEL, dev_to_node(dev));
>      197                 if (!wq) {
>      198                         rc = -ENOMEM;
>      199                         goto err;
> 
> On this error path we either free an uninitialized variable or we
> double free conf_dev.

Hi, Dan,

Thanks for reporting this bug:)

It has reported by Colin but he forgot to cc mailing list.
And I sent a patch to fix it:
https://lore.kernel.org/lkml/19668a72-c523-42ab-87ac-990a4baac214@intel.com/

> 
>      200                 }
>      201
>      202                 idxd_dev_set_type(&wq->idxd_dev, IDXD_DEV_WQ);
>      203                 conf_dev = wq_confdev(wq);
>      204                 wq->id = i;
>      205                 wq->idxd = idxd;
>      206                 device_initialize(wq_confdev(wq));
>      207                 conf_dev->parent = idxd_confdev(idxd);
>      208                 conf_dev->bus = &dsa_bus_type;
>      209                 conf_dev->type = &idxd_wq_device_type;
>      210                 rc = dev_set_name(conf_dev, "wq%d.%d", idxd->id, wq->id);
>      211                 if (rc < 0)
>      212                         goto err;
> 
> When we're cleaning up loops what I recommend is that we clean up the
> partial iterations before the goto.
> 
> 		if (rc < 0) {
> 			put_device(conf_dev);
> 			kfree(wq);
> 			goto unwind_loop;
> 		}
> 
> That's sort of how the code was written originally but it missed some
> frees.
> 
> 
>      213
>      214                 mutex_init(&wq->wq_lock);
>      215                 init_waitqueue_head(&wq->err_queue);
>      216                 init_completion(&wq->wq_dead);
>      217                 init_completion(&wq->wq_resurrect);
>      218                 wq->max_xfer_bytes = WQ_DEFAULT_MAX_XFER;
>      219                 idxd_wq_set_max_batch_size(idxd->data->type, wq, WQ_DEFAULT_MAX_BATCH);
>      220                 wq->enqcmds_retries = IDXD_ENQCMDS_RETRIES;
>      221                 wq->wqcfg = kzalloc_node(idxd->wqcfg_size, GFP_KERNEL, dev_to_node(dev));
>      222                 if (!wq->wqcfg) {
>      223                         rc = -ENOMEM;
>      224                         goto err;
>      225                 }
> 
> Same:
> 
> 		if (!wq->wqcfg) {
> 			put_device(conf_dev);
> 			kfree(wq);
> 			rc = -ENOMEM;
> 			goto unwind_loop;
> 		}
> 
>      226
>      227                 if (idxd->hw.wq_cap.op_config) {
>      228                         wq->opcap_bmap = bitmap_zalloc(IDXD_MAX_OPCAP_BITS, GFP_KERNEL);
>      229                         if (!wq->opcap_bmap) {
>      230                                 rc = -ENOMEM;
>      231                                 goto err_opcap_bmap;
>      232                         }
> 
> 		if (!wq->wqcfg) {
> 			kfree(wq->wqcfg);
> 			put_device(conf_dev);
> 			kfree(wq);
> 			rc = -ENOMEM;
> 			goto unwind_loop;
> 		}
> 
> 
>      233                         bitmap_copy(wq->opcap_bmap, idxd->opcap_bmap, IDXD_MAX_OPCAP_BITS);
>      234                 }
>      235                 mutex_init(&wq->uc_lock);
>      236                 xa_init(&wq->upasid_xa);
>      237                 idxd->wqs[i] = wq;
>      238         }
>      239
> 
> Imagine if we add another two allocations here.
> 
> 		foo = alloc();
> 		if (!foo)
> 			goto err;
> 		bar = alloc();
> 		if (!bar)
> 			goto free_foo;
> 
> 
>      240         return 0;
>      241
> 
> Then we have to do a little bunny hop.
> 
> free_foo:
> 	free(foo);
> 	goto err; // <-- bunny hop
> 
> err_opcap_bmap:
> 	kfree(wq->wqcfg);
> 
> People often get confused and forget the bunny hop.

I think so, this is the way I used in the original patch I send.
but reviewer Markus point to move common free code to additional
jump targets.

https://lore.kernel.org/lkml/98327a4d-7684-4908-9d67-5dfcaa229ae1@web.de/

I feel free to change back to clean up the partial iterations before the goto.
@Dave, which way do you like?

(Dave is on vacation, I can send a new patch if he prefer the latter way)

> 
>      242 err_opcap_bmap:
>      243         kfree(wq->wqcfg);
>      244
>      245 err:
> --> 246         put_device(conf_dev);
>      247         kfree(wq);
>      248
>      249         while (--i >= 0) {
>      250                 wq = idxd->wqs[i];
>      251                 if (idxd->hw.wq_cap.op_config)
>      252                         bitmap_free(wq->opcap_bmap);
>      253                 kfree(wq->wqcfg);
>      254                 conf_dev = wq_confdev(wq);
>      255                 put_device(conf_dev);
>      256                 kfree(wq);
>      257
>      258         }
>      259         bitmap_free(idxd->wq_enable_map);
>      260
>      261 err_bitmap:
>      262         kfree(idxd->wqs);
>      263
>      264         return rc;
>      265 }
> 
> regards,
> dan carpenter


Thanks.

Regards
Shuai

