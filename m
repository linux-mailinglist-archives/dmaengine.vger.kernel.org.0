Return-Path: <dmaengine+bounces-5268-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEFEAC3C3E
	for <lists+dmaengine@lfdr.de>; Mon, 26 May 2025 11:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 816973B7722
	for <lists+dmaengine@lfdr.de>; Mon, 26 May 2025 09:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB7F1D6193;
	Mon, 26 May 2025 09:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I/ccA301"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2371DE3C8
	for <dmaengine@vger.kernel.org>; Mon, 26 May 2025 09:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748250086; cv=none; b=nFpWGYsERF2/gjXVQ3A9bz2bexnjtUrXJ3IfWx85r4vK/g55ZLOK2MbSEigm8s/LDj2bFv4P9HoGf1dPXDXcFsX/DapJtRlRMBP3N3l3erto05IPhWkxZouuDH1uEzQAn+6LXHk+fF9EMSpwiGoZgWybxrrTY6HvZdN6TRHPyCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748250086; c=relaxed/simple;
	bh=qZ8a/wzgHRgnV/+OXVUjISE9WV8EyuMRegt9KnFqfW8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lOPjZVhoc8Z8m1qODd9crkywOfCzcu5V2R2aWh9adOB+9DJMfwGo+UXlCEAz+CZEQEColE4perkQKMsicPCde+7+oh2Xr4xltvYoWhLyMdgNm5S2cbgksqri4e9wz++0I+WCWIoVnQhXKFYZSZwV77HygEmIumoMUsj/qGAOTvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I/ccA301; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-442ea341570so14272815e9.1
        for <dmaengine@vger.kernel.org>; Mon, 26 May 2025 02:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748250083; x=1748854883; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rhDfqzGQ43DTbP8j6XW/+Wu55hrk6NWC9L/NiuHi/LA=;
        b=I/ccA301ERv453s5497P6JWlzUsCNgGldEwr6mzUnxhv3FiKfDUA7cWY1T24bhDuMR
         dSSZDNcbhcPI1UC5N6eLkEsX+mcHl4GtvwYNGCaDEq9TXiMvPkLwa1zQRi+L4jmFGH4I
         P+Gv8JpD3A7gStulwHmmCAZzeATeM0/M5NPMo7j+cutQ7IW2hVkoivBIzdEX2YQxmq/H
         FmZZm6hUJCrhZHm2tyCsNYbx2IiBVCWyB05NWUKNd5/O0cDaaYaWEFfdqypRAh9Tj3kJ
         KqhfOl18LApIT3LI1+ujI32HKfC59zu34h9eyhGWfwg8lFJ0SPRAYHAd4R0ebyUas7Kr
         qBvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748250083; x=1748854883;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rhDfqzGQ43DTbP8j6XW/+Wu55hrk6NWC9L/NiuHi/LA=;
        b=MRgR1HLwCFyYBPSEXDeoYpn9vnEbBoW+7p1s0bb+9DA0xysNeaSEBVE6qjohee0mXv
         AsaYsL8Z+CsxxjpPGjWaE7WeUaWyWvazsQYinniy7F5NPTWJVinTXr3eNttpCa6E1t57
         HY1Z4zoukuEwhblAajepRkKSMsGMCB522tpRV/s9/5i4fadiRKiF5mtWu8dbuHI8GYzb
         96ylrg4L06es3HIUw6z4bn6BVFgoLICvCo6V/IIEMG2fdNwUxGlpOCBN5R84GeOMEVpo
         njXaN99OgnTZYBq3v0SyLf6qN3b1gE7jQ3RokXNsQLplpx743DS3fhg43DQfZZQ4XD6Q
         8glg==
X-Gm-Message-State: AOJu0Yw6jW+N1cvDxgwHoAGvyA7Dk9uQiDU+knVE7niryT0gOxKp8b4i
	Te58nsbHLF6CUD27VP3DhftqLmikxNxJzitwOVFYydSZGYnz/HoA+rwM7Nhtkz7SgCkbW0vSUDH
	Lzkko
X-Gm-Gg: ASbGncs2w62wsmELPlHePffFk4zlvtwJLaJW6OnTq/XtP4BhSnY8wolOBnNjs0yMi9u
	Vl5y7+nvW1/4tMHTrFem8uSC2tfhNys7Wmta5/0+EVbyL2AWFwf13+qqsnqSjueuGh0o+vKyD3S
	X7mOxO67Pqht2fNvHqPKuz7WR0iCJNUvI3CWKm1Cvs6h4ZJIutlCfAtZ3lDZmgQ8k76o71BYBJM
	pE9fqmbAWzflb3ndaUgsKC6rABgLFgtM+iLCHGzXCY8skHqmHrUPQ6TN/ICA4bsFoBTqvXDlwuk
	b9aBilZ2unCi0ZbFT+5ZALBlwXbwEARxjt+Vld4ECaU4ZzLQFeyDURKQ
X-Google-Smtp-Source: AGHT+IHxtV4+3gh0C/cesx6Zo3UrF0Z3Xp2TmSozx5XMhhBpL4XCWsFhSBuM7IsuKYoShdYEiZ2MMg==
X-Received: by 2002:a05:600c:5126:b0:43d:a90:9f1 with SMTP id 5b1f17b1804b1-44c93016686mr71184365e9.6.1748250082800;
        Mon, 26 May 2025 02:01:22 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-447f1ef035csm225569045e9.11.2025.05.26.02.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 02:01:22 -0700 (PDT)
Date: Mon, 26 May 2025 12:01:19 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: dmaengine@vger.kernel.org
Subject: [bug report] dmaengine: idxd: fix memory leak in error handling path
 of idxd_setup_wqs
Message-ID: <aDQt3_rZjX-VuHJW@stanley.mountain>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Shuai Xue,

Commit 3fd2f4bc010c ("dmaengine: idxd: fix memory leak in error
handling path of idxd_setup_wqs") from Apr 4, 2025 (linux-next),
leads to the following Smatch static checker warning:

	drivers/dma/idxd/init.c:246 idxd_setup_wqs()
	error: uninitialized symbol 'conf_dev'.

drivers/dma/idxd/init.c
    177 static int idxd_setup_wqs(struct idxd_device *idxd)
    178 {
    179         struct device *dev = &idxd->pdev->dev;
    180         struct idxd_wq *wq;
    181         struct device *conf_dev;
    182         int i, rc;
    183 
    184         idxd->wqs = kcalloc_node(idxd->max_wqs, sizeof(struct idxd_wq *),
    185                                  GFP_KERNEL, dev_to_node(dev));
    186         if (!idxd->wqs)
    187                 return -ENOMEM;
    188 
    189         idxd->wq_enable_map = bitmap_zalloc_node(idxd->max_wqs, GFP_KERNEL, dev_to_node(dev));
    190         if (!idxd->wq_enable_map) {
    191                 rc = -ENOMEM;
    192                 goto err_bitmap;
    193         }
    194 
    195         for (i = 0; i < idxd->max_wqs; i++) {
    196                 wq = kzalloc_node(sizeof(*wq), GFP_KERNEL, dev_to_node(dev));
    197                 if (!wq) {
    198                         rc = -ENOMEM;
    199                         goto err;

On this error path we either free an uninitialized variable or we
double free conf_dev.

    200                 }
    201 
    202                 idxd_dev_set_type(&wq->idxd_dev, IDXD_DEV_WQ);
    203                 conf_dev = wq_confdev(wq);
    204                 wq->id = i;
    205                 wq->idxd = idxd;
    206                 device_initialize(wq_confdev(wq));
    207                 conf_dev->parent = idxd_confdev(idxd);
    208                 conf_dev->bus = &dsa_bus_type;
    209                 conf_dev->type = &idxd_wq_device_type;
    210                 rc = dev_set_name(conf_dev, "wq%d.%d", idxd->id, wq->id);
    211                 if (rc < 0)
    212                         goto err;

When we're cleaning up loops what I recommend is that we clean up the
partial iterations before the goto.

		if (rc < 0) {
			put_device(conf_dev);
			kfree(wq);
			goto unwind_loop;
		}

That's sort of how the code was written originally but it missed some
frees.


    213 
    214                 mutex_init(&wq->wq_lock);
    215                 init_waitqueue_head(&wq->err_queue);
    216                 init_completion(&wq->wq_dead);
    217                 init_completion(&wq->wq_resurrect);
    218                 wq->max_xfer_bytes = WQ_DEFAULT_MAX_XFER;
    219                 idxd_wq_set_max_batch_size(idxd->data->type, wq, WQ_DEFAULT_MAX_BATCH);
    220                 wq->enqcmds_retries = IDXD_ENQCMDS_RETRIES;
    221                 wq->wqcfg = kzalloc_node(idxd->wqcfg_size, GFP_KERNEL, dev_to_node(dev));
    222                 if (!wq->wqcfg) {
    223                         rc = -ENOMEM;
    224                         goto err;
    225                 }

Same:

		if (!wq->wqcfg) {
			put_device(conf_dev);
			kfree(wq);
			rc = -ENOMEM;
			goto unwind_loop;
		}

    226 
    227                 if (idxd->hw.wq_cap.op_config) {
    228                         wq->opcap_bmap = bitmap_zalloc(IDXD_MAX_OPCAP_BITS, GFP_KERNEL);
    229                         if (!wq->opcap_bmap) {
    230                                 rc = -ENOMEM;
    231                                 goto err_opcap_bmap;
    232                         }

		if (!wq->wqcfg) {
			kfree(wq->wqcfg);
			put_device(conf_dev);
			kfree(wq);
			rc = -ENOMEM;
			goto unwind_loop;
		}


    233                         bitmap_copy(wq->opcap_bmap, idxd->opcap_bmap, IDXD_MAX_OPCAP_BITS);
    234                 }
    235                 mutex_init(&wq->uc_lock);
    236                 xa_init(&wq->upasid_xa);
    237                 idxd->wqs[i] = wq;
    238         }
    239 

Imagine if we add another two allocations here.

		foo = alloc();
		if (!foo)
			goto err;
		bar = alloc();
		if (!bar)
			goto free_foo;


    240         return 0;
    241 

Then we have to do a little bunny hop.

free_foo:
	free(foo);
	goto err; // <-- bunny hop

err_opcap_bmap:
	kfree(wq->wqcfg);

People often get confused and forget the bunny hop.

    242 err_opcap_bmap:
    243         kfree(wq->wqcfg);
    244 
    245 err:
--> 246         put_device(conf_dev);
    247         kfree(wq);
    248 
    249         while (--i >= 0) {
    250                 wq = idxd->wqs[i];
    251                 if (idxd->hw.wq_cap.op_config)
    252                         bitmap_free(wq->opcap_bmap);
    253                 kfree(wq->wqcfg);
    254                 conf_dev = wq_confdev(wq);
    255                 put_device(conf_dev);
    256                 kfree(wq);
    257 
    258         }
    259         bitmap_free(idxd->wq_enable_map);
    260 
    261 err_bitmap:
    262         kfree(idxd->wqs);
    263 
    264         return rc;
    265 }

regards,
dan carpenter

