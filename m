Return-Path: <dmaengine+bounces-2950-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EED9C95CC1F
	for <lists+dmaengine@lfdr.de>; Fri, 23 Aug 2024 14:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DDF71C240D5
	for <lists+dmaengine@lfdr.de>; Fri, 23 Aug 2024 12:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83C41850B6;
	Fri, 23 Aug 2024 12:09:35 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FBD1849E7;
	Fri, 23 Aug 2024 12:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724414975; cv=none; b=spr3YIfT1sAko7fD6fGUedyXwZa6zHW3SVUpHfmAkKDRuqDJ0Oxsyqw7A++9h0s/3RwNqQHzNLJkepYKUgraDlYTWeCrBM0Dcw/3iDpM2KCc9N7GBRI6Q89PYeQd6yht26fJAYo2lvHiwNWi0oATgb7E+yUZnyXGLTqecLrNMWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724414975; c=relaxed/simple;
	bh=vtzHwlb10pbjVHE/89J3n12Y41FJCr01t6Ved+UUTSk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZKe+AhIDPzS/UfJlIyWq8p8NM657BfDHGibVDlyCzLYC1txqmARMI1yaNoZb9L6duCss2lJNGhYkuaBuixEUolWIXo+wfnj3DCKr6du+77a2LSB2Vjgp07hVGde6yQgJq/uV0IZqiN6kifZsjWeLUeztup2lN9W09lil5U/tJWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WqzLp5PsSz6K5lg;
	Fri, 23 Aug 2024 20:06:26 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 3A4091400DB;
	Fri, 23 Aug 2024 20:09:31 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 23 Aug
 2024 13:09:30 +0100
Date: Fri, 23 Aug 2024 13:09:29 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Liao Yuanhong <liaoyuanhong@vivo.com>
CC: <vkoul@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/6] dma:milbeaut-hdmac:Use devm_clk_get_enabled()
 helpers
Message-ID: <20240823130929.00002242@Huawei.com>
In-Reply-To: <20240823101933.9517-6-liaoyuanhong@vivo.com>
References: <20240823101933.9517-1-liaoyuanhong@vivo.com>
	<20240823101933.9517-6-liaoyuanhong@vivo.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 23 Aug 2024 18:19:32 +0800
Liao Yuanhong <liaoyuanhong@vivo.com> wrote:

> Use devm_clk_get_enabled() instead of clk functions in milbeaut-hdmac.
> 
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
This one is fine I think
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

