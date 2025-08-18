Return-Path: <dmaengine+bounces-6051-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F09B29AAD
	for <lists+dmaengine@lfdr.de>; Mon, 18 Aug 2025 09:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D4A57A6CE1
	for <lists+dmaengine@lfdr.de>; Mon, 18 Aug 2025 07:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09615279DA4;
	Mon, 18 Aug 2025 07:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="teFAK1vl"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E4E26FA5A
	for <dmaengine@vger.kernel.org>; Mon, 18 Aug 2025 07:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755501460; cv=none; b=jVNfn1bVXnnNUTomtIfhC352HB1Lc9FpnGWpuUR4YmyrueyxXHkbdgF9oh0nkNPs9AV3m0DbBQyJjOrR7U6mhoFTzfwfqfACOIkeevStgRw/8RxMEkmSrqbuqse47r5KxXdy02MMIXNeKMRvJIsFZgBFK0COuxQqYLxkdEgugec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755501460; c=relaxed/simple;
	bh=GRtOJJ4TU25SLYLaBruGe/0cKnzINtKI69UBlywJ0HU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=G/m1+RuXn3j3c5maQPDTey3YocDl+3AXLA1q+4PUUFjcU4M5xuBvAXOjUZQvKakRhSQ1C0wVA0Fo35Do6rOe6P1TeKpGxQFlgxfQV3KpaVhvtcSFa+1tt9fBZ5jcvLg22wNvAqm80dr+NsoRrC4O3Aksea4Axvx69RW4cWQKRgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=teFAK1vl; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3b9dc5cd4cbso2590582f8f.1
        for <dmaengine@vger.kernel.org>; Mon, 18 Aug 2025 00:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755501455; x=1756106255; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=00HmFiTKWlOUviqLOmDiviucp/G1KSLyabeRXjoLhH4=;
        b=teFAK1vlqjAnOufj1cK0esDy07iK6gIPAZO+Kj1pmsTWtYWHEi5Damcdt8kobHlO0n
         +EfMwuo5qdITFKs+ESDzB91C+xpDuInUEVpmKHoQ3aVz7VNki8YCwvssIVO4QWNL1p4f
         5o5KIrpybG816yrbD0w7hgF9hWhREA22eGasZUsmpmyPUwtOYkM9yrIbBKXIPmAqQLiD
         qgb4EJcRMokq4Iht9/A24DqEmIYFH5h92RR99dWD5xuwzF6KjFttfFa+dqDVkqOu5P/m
         wNnzcOdX9QvIngar97NEu59zd/7fue9bPHitIyhUfSeaGvLnsjhWKdSjDy7dSM7m7k09
         N5/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755501455; x=1756106255;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=00HmFiTKWlOUviqLOmDiviucp/G1KSLyabeRXjoLhH4=;
        b=bgmser36NwSwJNFN1Wp3WgVN7q3PSsTwFZ1WXjms8dkc/AvTiawwMmjDeXnfPUfxSs
         K2JSfKU8LsaadcQJTiS75Jaa9kk25hgx6SWouPNwjbaxzwjqm+ZnlyrHWs7R1Bv5cLAU
         ey1E9dQx8PPKGLmsF1E7+oX4xczmaTk8HvIPGDXtKa4rNRw+wrManfwZJg+Q7rzfJY2i
         hJCMVbe6lN+C9+mLvN3pOae9HfmKQ2HRU/Eq5SMXifU5JCtVuNa6i6Cd3YItvHIOx1s3
         bvYNL5A8t/N8TI19/ocTPRt5J+k52wVbl00QRgpsm5jk1OslqCugukS7hdzblas+8754
         KvxA==
X-Forwarded-Encrypted: i=1; AJvYcCVio/zDzVre9dxlunnYYepzanD1o2avH19ylhFrLyH8RIkgMIoeoT6dz4nmEp6Oh6QC92jAuQ65Zrc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCfbGF+cpOWEpGPYuRLjevu6EvOWkAriWScNiWc7N7bU4kJSEY
	B2rPlCfmVfJjY7ALFow6x7+4vc35ZqUYFRAa7UdW8wC0+mPY4DpIjLRGrtmaIfNI5QM=
X-Gm-Gg: ASbGncv2R8ElbuqjAe+DHPPhKw8+po8HXlmJlXcbyIwKBy5t8XBSkiBHQ6u9LmX0Vmm
	oNyXG7061DzQQNb6svZ3FJ+ERngdAy6xCYSTIopSUzcbw3/QtN6H9B3JJysjxUcPHylAR3IpXxw
	V+qK5uCGpb6sNvet+w9/vnAffIt1oG5y8X/K3jgCtwPxSmZDwlCVvtTgztc/08ynFmJ9kOYhXUC
	AXzFpFIov6Kc/fRw8+kZiHtL2b4oVlEYCZQh2ZmelLQmLx+2Q+umYUKWW07PHMkgB7o0Xd316oy
	a7mURMeg/ojHqjnsQR3mF1sX2+YvF1h/mQaBlALfRO2zKBlUtTb53rw5/ummsi1yjDLV6pqhAXe
	rzDeFAb7Du5bEhh701PiylvE+kqh3ds+SZbM4Jn6NIts=
X-Google-Smtp-Source: AGHT+IHyrx5So2JkHy8B3V9n10eIVkllRTMcnOfbIYL9Fak+QjG/0EyC3RMUePQ7ZAM0RE6YfPigZA==
X-Received: by 2002:a05:6000:250c:b0:3b7:8473:31c3 with SMTP id ffacd0b85a97d-3bb6646e10amr7831271f8f.9.1755501455230;
        Mon, 18 Aug 2025 00:17:35 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3bb67c902dbsm11683675f8f.47.2025.08.18.00.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 00:17:34 -0700 (PDT)
Date: Mon, 18 Aug 2025 10:17:31 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Guodong Xu <guodong@riscstar.com>,
	Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	duje@dujemihanovic.xyz
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	Alex Elder <elder@riscstar.com>,
	Vivian Wang <wangruikang@iscas.ac.cn>, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	Guodong Xu <guodong@riscstar.com>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>
Subject: Re: [PATCH v4 4/8] dmaengine: mmp_pdma: Add operations structure for
 controller abstraction
Message-ID: <202508181040.az8RxLrG-lkp@intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815-working_dma_0701_v2-v4-4-62145ab6ea30@riscstar.com>

Hi Guodong,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Guodong-Xu/dt-bindings-dma-Add-SpacemiT-K1-PDMA-controller/20250815-132049
base:   062b3e4a1f880f104a8d4b90b767788786aa7b78
patch link:    https://lore.kernel.org/r/20250815-working_dma_0701_v2-v4-4-62145ab6ea30%40riscstar.com
patch subject: [PATCH v4 4/8] dmaengine: mmp_pdma: Add operations structure for controller abstraction
config: parisc-randconfig-r072-20250818 (https://download.01.org/0day-ci/archive/20250818/202508181040.az8RxLrG-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 8.5.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202508181040.az8RxLrG-lkp@intel.com/

smatch warnings:
drivers/dma/mmp_pdma.c:546 mmp_pdma_prep_memcpy() warn: variable dereferenced before check 'dchan' (see line 542)
drivers/dma/mmp_pdma.c:712 mmp_pdma_prep_dma_cyclic() warn: variable dereferenced before check 'dchan' (see line 708)

vim +/dchan +546 drivers/dma/mmp_pdma.c

c8acd6aa6bed3c Zhangfei Gao     2012-09-03  536  static struct dma_async_tx_descriptor *
c8acd6aa6bed3c Zhangfei Gao     2012-09-03  537  mmp_pdma_prep_memcpy(struct dma_chan *dchan,
c8acd6aa6bed3c Zhangfei Gao     2012-09-03  538  		     dma_addr_t dma_dst, dma_addr_t dma_src,
c8acd6aa6bed3c Zhangfei Gao     2012-09-03  539  		     size_t len, unsigned long flags)
c8acd6aa6bed3c Zhangfei Gao     2012-09-03  540  {
c8acd6aa6bed3c Zhangfei Gao     2012-09-03  541  	struct mmp_pdma_chan *chan;
918da7ee50b22b Guodong Xu       2025-08-15 @542  	struct mmp_pdma_device *pdev = to_mmp_pdma_dev(dchan->device);
                                                                                                       ^^^^^^^^^^^^^
The patch adds a new dereference

c8acd6aa6bed3c Zhangfei Gao     2012-09-03  543  	struct mmp_pdma_desc_sw *first = NULL, *prev = NULL, *new;
c8acd6aa6bed3c Zhangfei Gao     2012-09-03  544  	size_t copy = 0;
c8acd6aa6bed3c Zhangfei Gao     2012-09-03  545  
c8acd6aa6bed3c Zhangfei Gao     2012-09-03 @546  	if (!dchan)
                                                            ^^^^^^
But the old existing code assumed dchan could be NULL

c8acd6aa6bed3c Zhangfei Gao     2012-09-03  547  		return NULL;
c8acd6aa6bed3c Zhangfei Gao     2012-09-03  548  
c8acd6aa6bed3c Zhangfei Gao     2012-09-03  549  	if (!len)
c8acd6aa6bed3c Zhangfei Gao     2012-09-03  550  		return NULL;
c8acd6aa6bed3c Zhangfei Gao     2012-09-03  551  
c8acd6aa6bed3c Zhangfei Gao     2012-09-03  552  	chan = to_mmp_pdma_chan(dchan);

[ snip ]

2b7f65b11d87f9 Joe Perches      2013-11-17  701  static struct dma_async_tx_descriptor *
2b7f65b11d87f9 Joe Perches      2013-11-17  702  mmp_pdma_prep_dma_cyclic(struct dma_chan *dchan,
2b7f65b11d87f9 Joe Perches      2013-11-17  703  			 dma_addr_t buf_addr, size_t len, size_t period_len,
2b7f65b11d87f9 Joe Perches      2013-11-17  704  			 enum dma_transfer_direction direction,
31c1e5a1350ae8 Laurent Pinchart 2014-08-01  705  			 unsigned long flags)
50440d74aae318 Daniel Mack      2013-08-21  706  {
50440d74aae318 Daniel Mack      2013-08-21  707  	struct mmp_pdma_chan *chan;
918da7ee50b22b Guodong Xu       2025-08-15 @708  	struct mmp_pdma_device *pdev = to_mmp_pdma_dev(dchan->device);
                                                                                                       ^^^^^^^^^^^^^


50440d74aae318 Daniel Mack      2013-08-21  709  	struct mmp_pdma_desc_sw *first = NULL, *prev = NULL, *new;
50440d74aae318 Daniel Mack      2013-08-21  710  	dma_addr_t dma_src, dma_dst;
50440d74aae318 Daniel Mack      2013-08-21  711  
50440d74aae318 Daniel Mack      2013-08-21 @712  	if (!dchan || !len || !period_len)
                                                            ^^^^^^
Same.


50440d74aae318 Daniel Mack      2013-08-21  713  		return NULL;
50440d74aae318 Daniel Mack      2013-08-21  714  
50440d74aae318 Daniel Mack      2013-08-21  715  	/* the buffer length must be a multiple of period_len */

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


