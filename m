Return-Path: <dmaengine+bounces-2361-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9DE90754B
	for <lists+dmaengine@lfdr.de>; Thu, 13 Jun 2024 16:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C97791F22C54
	for <lists+dmaengine@lfdr.de>; Thu, 13 Jun 2024 14:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC47145B02;
	Thu, 13 Jun 2024 14:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nMhppxdh"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FAD145A1D
	for <dmaengine@vger.kernel.org>; Thu, 13 Jun 2024 14:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718289486; cv=none; b=ueLSFqm+UOjBOKWwCCZnhcAjTg7vvmwLOCNV+tBS0sfpRXTKkE7YOvL7qemLUTi7tb58UTL6v6eR8Ofc2DDWUs1iHNkye5fftj+IxVcRFabnpt4+0EI0Ol46J/FR0ftHbCUFZKzLS7W1u8+utxDf02R9avQPbUsp9yXZKjTca04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718289486; c=relaxed/simple;
	bh=Mp69dkFfHyqpxOw6HmrqgKVkRjiRvsVD1DyMz/W7tu4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VmF66tW85002sptgj3lO58BDxi83ZDB2IpZ0hRSFGVQLFU9dHEx5pKsMN1jwIs/EQuOdX4EWIbvoqAPLrJhZrZhJC47zaNmx1mn4/P4USKVToyjDSBdfMDYK101TtODngpj+Uv9vgGOl7i08FDjEXW8SfVdRnNCQl+Pcm+8fnKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nMhppxdh; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42138eadf64so9748315e9.3
        for <dmaengine@vger.kernel.org>; Thu, 13 Jun 2024 07:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718289483; x=1718894283; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G+nIt8d2t4DiavLGy5cfHV1hWynf/ICQ/cw2rUs539w=;
        b=nMhppxdhJqDR9yWg+mngQ5JnKiWkVJV6q3JzCAazKlDzeynFQW5ALc/Op25z9qCP4g
         BYF4dOz6Yjgs3SFK3OdP+YQ+jsHGV1vsCxtSsWr7NoxpybnWWUXsZKzxrOlreVV5Wm/T
         zQwLiddZZRW4FzMiTFTfgzeqaJVvgAbSBe26XFiedDc9T1EcrYsv/NDNX8ItvY5RB7vA
         8cjENVDofWmLAABiGXXDzIRkvyPGbEwHZPgSuDmIeb+ixjE1H8zdldOTbyxje+TzR5+Z
         NJXgYBRXsl/r1W/gkR6YtM/D9/DMnJ5Ql4ggK74ZQlhuFEEjGVuCau+KFns6NNTb25Mz
         RbTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718289483; x=1718894283;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G+nIt8d2t4DiavLGy5cfHV1hWynf/ICQ/cw2rUs539w=;
        b=bBQ9I3ygA5Hn3xupKH3MKj0h9JhuYkQM3Fsq6Isw2vmciDiVNa/9S/n5F0XDZ/VSXc
         YhsvX4w1FwcjBv9Xj+GKwD9bAkuJoQWhSQwS3hjrEfgqeC7FLUged/Ow1uRJXIX+UpuY
         nVSaQjg5Zp/KNVljTiiH5TKTWuNGK6svkM00XfacWXNbgVppAlhWd3gHUIR1L3STkXLA
         RsT4wud8dcxrHHMCjJCRBVysv1VhlB5P5r4Tx37siSAP0wBty1AvjQPrvjSAjmWwMoxv
         /ynK/fqrU2gBWDQGkc1ltOv1K/Z8EdcMGG/s1AypMPjTtdEry7XBuL9Qvf5jjF6fKP3Z
         KUNA==
X-Gm-Message-State: AOJu0YzoiRMHgkm3cmOd1HHOvel6RkJWXfUIPm/l/D+pQvtTLFjibH6a
	bAHfIeQwvFlK9rn8YrBM6jyoG0Iv1luBm/MWMp3W9ZSKmcCNzulw0pgbW62OgFVfmQzO608D9b4
	w
X-Google-Smtp-Source: AGHT+IEwABxVBLZB6D5Y71OSurFuEm7/xV5anXbmAmH7asLtYQmmh0SMCVS9kqM2/yJIVGx0THEZhg==
X-Received: by 2002:a05:600c:4f91:b0:422:683b:df2a with SMTP id 5b1f17b1804b1-423048273d2mr215925e9.13.1718289482681;
        Thu, 13 Jun 2024 07:38:02 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f5f33c43sm27991045e9.7.2024.06.13.07.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 07:38:02 -0700 (PDT)
Date: Thu, 13 Jun 2024 17:37:58 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Peng Ma <peng.ma@nxp.com>
Cc: dmaengine@vger.kernel.org
Subject: [bug report] dmaengine: fsl-qdma: Add qDMA controller driver for
 Layerscape SoCs
Message-ID: <3356b622-d321-471f-ab29-2af9f9684f80@moroto.mountain>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Peng Ma,

Commit b092529e0aa0 ("dmaengine: fsl-qdma: Add qDMA controller driver
for Layerscape SoCs") from Oct 30, 2018 (linux-next), leads to the
following Smatch static checker warning:

	drivers/dma/fsl-qdma.c:331 fsl_qdma_free_chan_resources()
	error: we previously assumed 'fsl_queue->comp_pool' could be null (see line 324)

drivers/dma/fsl-qdma.c
    309 static void fsl_qdma_free_chan_resources(struct dma_chan *chan)
    310 {
    311         struct fsl_qdma_chan *fsl_chan = to_fsl_qdma_chan(chan);
    312         struct fsl_qdma_queue *fsl_queue = fsl_chan->queue;
    313         struct fsl_qdma_engine *fsl_qdma = fsl_chan->qdma;
    314         struct fsl_qdma_comp *comp_temp, *_comp_temp;
    315         unsigned long flags;
    316         LIST_HEAD(head);
    317 
    318         spin_lock_irqsave(&fsl_chan->vchan.lock, flags);
    319         vchan_get_all_descriptors(&fsl_chan->vchan, &head);
    320         spin_unlock_irqrestore(&fsl_chan->vchan.lock, flags);
    321 
    322         vchan_dma_desc_free_list(&fsl_chan->vchan, &head);
    323 
    324         if (!fsl_queue->comp_pool && !fsl_queue->desc_pool)

This should probably be || instead of &&.

    325                 return;
    326 
    327         list_for_each_entry_safe(comp_temp, _comp_temp,
    328                                  &fsl_queue->comp_used,        list) {
    329                 dma_pool_free(fsl_queue->comp_pool,
                                      ^^^^^^^^^^^^^^^^^^^^
If only one is free but not the other then it leads to an Oops.

    330                               comp_temp->virt_addr,
--> 331                               comp_temp->bus_addr);
    332                 dma_pool_free(fsl_queue->desc_pool,
                                      ^^^^^^^^^^^^^^^^^^^^

    333                               comp_temp->desc_virt_addr,
    334                               comp_temp->desc_bus_addr);
    335                 list_del(&comp_temp->list);
    336                 kfree(comp_temp);
    337         }

regards,
dan carpenter

