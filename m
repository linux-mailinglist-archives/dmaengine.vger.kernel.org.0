Return-Path: <dmaengine+bounces-3568-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 769AD9AFD72
	for <lists+dmaengine@lfdr.de>; Fri, 25 Oct 2024 11:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 218831F21554
	for <lists+dmaengine@lfdr.de>; Fri, 25 Oct 2024 09:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842E31D26FE;
	Fri, 25 Oct 2024 09:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D2D0bU+t"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5126C1D222F
	for <dmaengine@vger.kernel.org>; Fri, 25 Oct 2024 09:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729846808; cv=none; b=pvZKfRmDc5XxBDb7oQNVVjcQk08jK/vKzxHwhCHyipDsqKzCK+QsVi6XDNW7iYJkX7C+fWAlg+PzxbhRZD/XsufdOB8921kbHLoFF0AYLRud+02DVx9lvUCLrYO7Q8lMU3KdPXnKtWble6FtzqXpjnk7uJg9neYV3sNNV4mdzk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729846808; c=relaxed/simple;
	bh=P+XWa+/ucuu68ijwXVuyz3hjxWpg+ffwGK49V3b/gN4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HiOvG0u9sS/jbB4Tdic3YsPjHlfdA7mUeMsdAa1RtaOMWE7zrhtuhQde95In17j/XxEJRxyJ3uOIICoyJNiCVfMciYc43iDBFnYUg0REj3nlYLxMgmc4rZziP5ltzws77ZiVOMa6EQHLDv7SWHt7FbX9GpMX5cOxPP09s006eLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D2D0bU+t; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4315baa51d8so18400005e9.0
        for <dmaengine@vger.kernel.org>; Fri, 25 Oct 2024 02:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729846804; x=1730451604; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q0+dpQpxKAfr64Yd3ROnrVjpJI2KdyLt9zHnOibR2+E=;
        b=D2D0bU+tvbVyZ2z87Hv8Le8ox9y+a73EmYUcGzeSZ9unSiOOxJFaPqf+oLxllgiSNr
         spaKgn7fIjD8cAymn0QDawUmRdcrJ1Nyqml0Uf2Y/dVEkEWQrj+Qv395AoS5Sz8RNyag
         JQOSQpL8YqZvjuXX2MuEt3sDUSRF7AzgQzpjc8ZI7IR/JcfHXWpUYtxLlbksTuvERgJW
         5u/gkZSXrkmU8gttKg1yNuH44PKtq4hzJkTINDFd3zUGTAPXtE0Khthkq1rRxXRnrIXY
         FivLdWRZtGlp5NTD0c0UnF7bUJdHiGq8U+4jSBIcxB0vJEhpHE6Sbh682x7ywlr9dWzF
         n9zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729846804; x=1730451604;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q0+dpQpxKAfr64Yd3ROnrVjpJI2KdyLt9zHnOibR2+E=;
        b=xALSHGhXLT48lSL4IbY9kr6tOpN/Dyx5VkQsvnT4ToRRcjvBAGyDwpSIaKSUUmx39z
         HTBDDeAJSJ+HKjb70pVMdTypShWvWFMlqoAKCt00Ieiln4gCVtYTsQ/oZP3e1VLqpLC8
         4fDaBLtooUWbVveHgNZOLxA8OBLmcj2uzw8m5Fq+/OF2l8wve+aQRxzW5Ctri5XKP6Gd
         9Kt3DBSIKmb4Ks8W9nOtPIvoWItWtLh26VLzfMzrECOM86lfttzW4ky2TwiRDYB4TGpB
         y5yvP5PeKjkNJole/nB5llLGzGaVE/5f/M1A7R8hDFdzOjZSi52WBY6a9rxiRIIzkeDc
         aHxQ==
X-Gm-Message-State: AOJu0YyFtFDyXfdDfKmmJ3GC8T5CAKGQDvydNnzqeC1tG6Au4L2JKAoc
	dTj3QAKAxjGaWoeqxFBkRgwrs0cHaL1wT5qjZndOYQj0s6Sw5z/JcQEon+FMXu5o80gxlspmZrM
	vmlUpXw==
X-Google-Smtp-Source: AGHT+IH0n2MLbHVsLr3p+kOyK8o8l6g1I/9lYbZF/XY+cWvkkzOseNbGrgDjdxA4XyD5OgmlO8R+TA==
X-Received: by 2002:a05:600c:4791:b0:431:5c36:6de7 with SMTP id 5b1f17b1804b1-43184948c35mr71208585e9.7.1729846804463;
        Fri, 25 Oct 2024 02:00:04 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431935f6df1sm11763465e9.35.2024.10.25.02.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 02:00:03 -0700 (PDT)
Date: Fri, 25 Oct 2024 11:59:59 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: dmaengine@vger.kernel.org
Subject: [bug report] dmaengine: ls2x-apb: New driver for the Loongson LS2X
 APB DMA controller
Message-ID: <87cdc025-7246-4548-85ca-3d36fdc2be2d@stanley.mountain>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Binbin Zhou,

Commit 71e7d3cb6e55 ("dmaengine: ls2x-apb: New driver for the
Loongson LS2X APB DMA controller") from Dec 18, 2023 (linux-next),
leads to the following Smatch static checker warning:

	drivers/dma/loongson2-apb-dma.c:189 ls2x_dma_write_cmd()
	warn: was expecting a 64 bit value instead of '~(((0)) + (((~((0))) - (((1)) << (0)) + 1) & (~((0)) >> ((8 * 4) - 1 - (4)))))'

drivers/dma/loongson2-apb-dma.c
    184 static void ls2x_dma_write_cmd(struct ls2x_dma_chan *lchan, bool cmd)
    185 {
    186         struct ls2x_dma_priv *priv = to_ldma_priv(lchan->vchan.chan.device);
    187         u64 val;
    188 
--> 189         val = lo_hi_readq(priv->regs + LDMA_ORDER_ERG) & ~LDMA_CONFIG_MASK;

On a 32bit build the ~LDMA_CONFIG_MASK will zero out the high 32 bits.  Should
LDMA_CONFIG_MASK be defined with GENMASK_ULL()?

    190         val |= LDMA_64BIT_EN | cmd;
    191         lo_hi_writeq(val, priv->regs + LDMA_ORDER_ERG);
    192 }

regards,
dan carpenter

