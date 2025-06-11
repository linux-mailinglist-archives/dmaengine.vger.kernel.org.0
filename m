Return-Path: <dmaengine+bounces-5364-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43501AD56C7
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 15:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E906A1680AC
	for <lists+dmaengine@lfdr.de>; Wed, 11 Jun 2025 13:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CD428751C;
	Wed, 11 Jun 2025 13:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hgTspcjg"
X-Original-To: dmaengine@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4A52874EB;
	Wed, 11 Jun 2025 13:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749647954; cv=none; b=YpHrdca1Jvp6Hh0Ainz/Ct4qNvtDtMepST+VhGnYqVMnVE/LeU5VHkYzE/R7JLITeOqyateRnCHcwYctL9ALq3qKW9iRei3pRxjUxDrB/TMnHlNjC0OQ1iHPy5Zvy/ulZNmG3dExhjE5EErI+ey+aF+W9XfZj+jHPMkss65m/x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749647954; c=relaxed/simple;
	bh=YnZHAH16ZCoZK3qgLn0+Hvc/WENmD4Pl8KAmSNL+Yb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nGfVPqh4+qAyGW27gwAL+/a6eiqcylabUbZzFEp7/z3tPM07aceL/kzOgL++7fIToaJFIL/Ldhf623N5pUdQEI2yzmUpY+g/ixm84D1ImihVo3De3gg35ecSp1yCMevzola/x/zDHqBCMmrHYtb0FWJtrHvZJX8TmHIxZhHlmmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hgTspcjg; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1749647950;
	bh=YnZHAH16ZCoZK3qgLn0+Hvc/WENmD4Pl8KAmSNL+Yb4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hgTspcjgX5qjLaXGcb9UQ23SvAQx4tbGKCiiY8/fTGjJe9k1HOPJTTX9CgF7mEre5
	 TN/wXhIC60siTNtw9EUYa7edrD966CThz8qEStNlBLsKXxFNQelpFiL+nvtcHqxbWq
	 buacOZ8MqQkH35PC/p4BAWR8sdhJVlEU7OPGm69fMSlwbcYyqJblLqgsLP++z93uIU
	 zWvR9ZQ1XHaxT1u2sIiPxyy+AbLoGn21ZuK4ZVXYPlfR62kcAl51hv87hTP0eb2/MV
	 +XgbdyjEjnSAuWBL/vfbPjxWJ0q4sc6K1aIBYBfbIqZDO2gpvwLnSg54RPYGL0WlMF
	 6w05HwFDBp43g==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1230E17E0E3A;
	Wed, 11 Jun 2025 15:19:10 +0200 (CEST)
Message-ID: <313cea9f-f6c5-449a-bcf0-80eb5088b7f3@collabora.com>
Date: Wed, 11 Jun 2025 15:19:09 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dmaengine: mediatek: Fix a flag reuse error in
 mtk_cqdma_tx_status()
To: Qiu-ji Chen <chenqiuji666@gmail.com>, sean.wang@mediatek.com,
 vkoul@kernel.org, matthias.bgg@gmail.com, eugen.hristev@linaro.org
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 baijiaju1990@gmail.com, stable@vger.kernel.org,
 kernel test robot <lkp@intel.com>
References: <20250606090017.5436-1-chenqiuji666@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250606090017.5436-1-chenqiuji666@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 06/06/25 11:00, Qiu-ji Chen ha scritto:
> Fixed a flag reuse bug in the mtk_cqdma_tx_status() function.
> 
> Fixes: 157ae5ffd76a ("dmaengine: mediatek: Fix a possible deadlock error in mtk_cqdma_tx_status()")
> Cc: stable@vger.kernel.org
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202505270641.MStzJUfU-lkp@intel.com/
> Signed-off-by: Qiu-ji Chen <chenqiuji666@gmail.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



