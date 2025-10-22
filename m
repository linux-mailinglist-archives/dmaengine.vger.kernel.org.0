Return-Path: <dmaengine+bounces-6927-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7117BFBC76
	for <lists+dmaengine@lfdr.de>; Wed, 22 Oct 2025 14:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7181B406645
	for <lists+dmaengine@lfdr.de>; Wed, 22 Oct 2025 12:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C659340A46;
	Wed, 22 Oct 2025 12:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mAb/BAuD"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E53033FE02
	for <dmaengine@vger.kernel.org>; Wed, 22 Oct 2025 12:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761134899; cv=none; b=NMvff0blhmTreA2glP4ccoqPRf8swRKXEyLj0FQhu6mLyUJ+oPZwNRvP1wi42BizzJcM1KL5OIe/QT1CqlI8AIRtX+Wj2eIy5tiuKVjVLTmtlAG25I/NnxnZvwDan+7Fq5UDgZRWgvjT+HAWH66hfy9zLQvWwaMLpSAUMxjb9kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761134899; c=relaxed/simple;
	bh=tZhHNi5tiOiq5ZyFScnnqPfCNqj/bQHHe9aIYrpZW4I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=iO7g0fFRhJX71vgZKduVpRTBkBWelLnwdTnxLJbRGvfac3veRXLLSkMlwGM65NwARbJqtHLSgXLRywKkSvVghHdva+rGR3ol1TymWIy0vEn4NqzlHnVbPQNWhNkkMkLGXcHakXzdOgb3f4H5GBGiSXiQVc0R7Qql/UshrO9kMp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mAb/BAuD; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4283be7df63so2124056f8f.1
        for <dmaengine@vger.kernel.org>; Wed, 22 Oct 2025 05:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761134895; x=1761739695; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DvbnSMIYk5HD128ctAAfLOD94aj1lQC5qodcVPOSef8=;
        b=mAb/BAuDoSfCWnlXuhzOZxDIIkeYs1WisznnsMqjrFqo98GMGDq/bZOuWeKp1aQcry
         +Jph9qfwTrxt2IK4e2YaizdedWsKnmnifSTkoGjx6hcYuBAAY6VX2aWvOPgGeb5V0w5B
         4+JG9QD0Uu7qFWT4z+rxiz8j/1GbyP5c9vT1t1rKF8W+aMHAAVP3KybcO3YsUV272ZNt
         2r3xdqKtV8BYIsIMPBcDHssOEvAi+T5YAH2LTMAomGrKvg/1Szbo72ZQw52kxqxviGEu
         AFn6qjKTqw9ecfjgxFsUbG5m0BL32XQyQLtDf64P/syrq8I97t7Lto6oPC4s3PH7HEM/
         QgVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761134895; x=1761739695;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DvbnSMIYk5HD128ctAAfLOD94aj1lQC5qodcVPOSef8=;
        b=Y0EUl0XGJUhaQtFoLIMWlydRxILMFK41fYeaKiT58M7m/XSW+xjYXuurBFLtx+sUBd
         fc5ACq5wdW1Xr9SBAdWlWAJhL2hUhZCjfbacTl6piKh5rW88Z7n3jVMa+/x/vYRaXd/7
         d++IwCS7oKDsmTyUBXl7vzslw4CVIOgYBL2q1S8P40Byo9uQY0x2VBYEvpMPnwopPHfL
         MietPfFea1XkXQiobC/W/E2ISkqxsBj6E1bme9pvDFjExxHBTPwNxTZvCz5RIBEtUZ7f
         Pwmc+/v+DvKt/oIPx9JLsq8nT0/ViG3P2PC1S0XMgGF4zgvoRls4fIv8oEU4JLc/sCZx
         SDvg==
X-Forwarded-Encrypted: i=1; AJvYcCXjXSizYgBAMKOzGObzTbmSOVmLteTdgxapIdo5k2+FmE4E/gzzWrAmbl94U/mzZU4R8DL1dBBGews=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1Co0Q4fW69Q2MrPoAAGcZdfPqBEdccdb5VY95HJLuISdHX4NA
	SdHVPM80v1nrW+JCS1KILtB1y2D7w4Z9mSrn2V/lJItFRVUlHe6hNu7108Z0Qji0h1k=
X-Gm-Gg: ASbGncsLux8zzRgfoNiacY2PL1wmqM+dWPTswFB5prAQjq4v41aXvb7Pzrq9oZ0vFZ7
	HtHmciVEKW7pSvzdFFrvM/h1LcWzUyK/lvWLcIpDpFzurFPNEP87kMlIkeO4diCnzLAie0i30VH
	3Q1VZ1gvfNZC8paMvlOcKroclDRYf2NtFj+qV6xhscgWPPP73xYXKBSgyj6iLthUkBvcRVWFGP8
	ruu53cazNA3avVk+umbxd7X6Yr7owbLybeV/UrEN/Y3Hz5guLp+cZJREzQ7WnLjUDnGdxzYWVs/
	7TfEY8oASZEJgOgxyk6rwlDlTl/LZgmZqJvikJsScuro1XywD9eBtES5OGmT5PbeOdR13K+oXOQ
	aqI4sJ8+lamIOg2435ejySAzNRCt+DPIjAb540v1POOJK260DSczwWbdBTujdR6VovMlh/sYICx
	2npDLUt75wJIr0iS7I
X-Google-Smtp-Source: AGHT+IFtLElvxR81Tckw5mAAABXqwaPNv/lBu1tgkcuWlvZJfGpip3RMbzFOLoUXkftAvfjFkop/kg==
X-Received: by 2002:a5d:5f82:0:b0:3fa:5925:4b07 with SMTP id ffacd0b85a97d-42704d74f9fmr12489147f8f.18.1761134895206;
        Wed, 22 Oct 2025 05:08:15 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-47496cf3b51sm35168225e9.9.2025.10.22.05.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 05:08:14 -0700 (PDT)
Date: Wed, 22 Oct 2025 15:08:10 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Artem Shimko <a.shimko.dev@gmail.com>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	Artem Shimko <a.shimko.dev@gmail.com>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] dmaengine: dw-axi-dmac: add reset control support
Message-ID: <202510221508.PY6fB9CB-lkp@intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017102950.206443-3-a.shimko.dev@gmail.com>

Hi Artem,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Artem-Shimko/dmaengine-dw-axi-dmac-simplify-PM-functions-and-use-modern-macros/20251017-183103
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git next
patch link:    https://lore.kernel.org/r/20251017102950.206443-3-a.shimko.dev%40gmail.com
patch subject: [PATCH v4 2/2] dmaengine: dw-axi-dmac: add reset control support
config: loongarch-randconfig-r072-20251019 (https://download.01.org/0day-ci/archive/20251022/202510221508.PY6fB9CB-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 15.1.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202510221508.PY6fB9CB-lkp@intel.com/

New smatch warnings:
drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:1355 axi_dma_resume() warn: 'chip->core_clk' from clk_prepare_enable() not released on lines: 1350.

Old smatch warnings:
drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:1237 dma_chan_pause() warn: inconsistent indenting
drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:1284 axi_chan_resume() warn: inconsistent indenting
drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c:1355 axi_dma_resume() warn: 'chip->cfgr_clk' from clk_prepare_enable() not released on lines: 1346,1350.

vim +1355 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c

45fdf99125b2bf7 Artem Shimko    2025-10-17  1335  static int axi_dma_resume(struct device *dev)

I guess kbuild bot thinks these are new warnings because the function
was renamed.  In the past we've just ignored clk_prepare_enable() warnings.
Perhaps that's the correct thing to do in a resume function.
The indenting in dma_chan_pause() and axi_chan_resume() could be cleaned up.

1fe20f1b84548bb Eugeniy Paltsev 2018-03-06  1336  {
1fe20f1b84548bb Eugeniy Paltsev 2018-03-06  1337  	int ret;
45fdf99125b2bf7 Artem Shimko    2025-10-17  1338  	struct axi_dma_chip *chip = dev_get_drvdata(dev);
1fe20f1b84548bb Eugeniy Paltsev 2018-03-06  1339  
1fe20f1b84548bb Eugeniy Paltsev 2018-03-06  1340  	ret = clk_prepare_enable(chip->cfgr_clk);
1fe20f1b84548bb Eugeniy Paltsev 2018-03-06  1341  	if (ret < 0)
1fe20f1b84548bb Eugeniy Paltsev 2018-03-06  1342  		return ret;
1fe20f1b84548bb Eugeniy Paltsev 2018-03-06  1343  
1fe20f1b84548bb Eugeniy Paltsev 2018-03-06  1344  	ret = clk_prepare_enable(chip->core_clk);
1fe20f1b84548bb Eugeniy Paltsev 2018-03-06  1345  	if (ret < 0)
1fe20f1b84548bb Eugeniy Paltsev 2018-03-06  1346  		return ret;
1fe20f1b84548bb Eugeniy Paltsev 2018-03-06  1347  
9c360f02c387f93 Artem Shimko    2025-10-17  1348  	ret = reset_control_deassert(chip->resets);
9c360f02c387f93 Artem Shimko    2025-10-17  1349  	if (ret)
9c360f02c387f93 Artem Shimko    2025-10-17  1350  		return ret;
9c360f02c387f93 Artem Shimko    2025-10-17  1351  
1fe20f1b84548bb Eugeniy Paltsev 2018-03-06  1352  	axi_dma_enable(chip);
1fe20f1b84548bb Eugeniy Paltsev 2018-03-06  1353  	axi_dma_irq_enable(chip);
1fe20f1b84548bb Eugeniy Paltsev 2018-03-06  1354  
1fe20f1b84548bb Eugeniy Paltsev 2018-03-06 @1355  	return 0;
1fe20f1b84548bb Eugeniy Paltsev 2018-03-06  1356  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


