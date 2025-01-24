Return-Path: <dmaengine+bounces-4188-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 536CEA1B3EB
	for <lists+dmaengine@lfdr.de>; Fri, 24 Jan 2025 11:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B76018825F6
	for <lists+dmaengine@lfdr.de>; Fri, 24 Jan 2025 10:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670C61D14E2;
	Fri, 24 Jan 2025 10:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="H/wj1Sz/"
X-Original-To: dmaengine@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA33D1CEEAA;
	Fri, 24 Jan 2025 10:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737715847; cv=none; b=i1z2BhXHiwtIwlyuIz4oQOdN2WGZ815+B/w9RTR3CNpPCJz2jxsKXeith+3x3apGtDSewYVCKgUijxy6ePKbNRK0PKKqt4h8xQM7WUfBOAIw25OQyhTtBxA/UGru3Blj1tTGVwmkAipgfZOEJujbKMzl1VRYSvjoPmJNG9C0KO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737715847; c=relaxed/simple;
	bh=vQ3QgVy3CkIBUmALyEBtabIgy3BO2W/ckTSgo2keC6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=d+jc9hpy2UWwu82yNVW7uOQ/zgzipB0rF1Usm6r+r/9JXYZjTCElz3A6wR0b/e6dZUWrsGWySUfaZxOjGngO+gqHbb1vkpYhlC3Am1ACzpk66Z0eVz6AUwMxVMDafs4V5SvVjnKdrgMI62hCpclcX4+ES2JLbMXFKprOCxmGAfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=H/wj1Sz/; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 8D9AEA0578;
	Fri, 24 Jan 2025 11:50:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:content-transfer-encoding:content-type:content-type:date:from
	:from:in-reply-to:message-id:mime-version:references:reply-to
	:subject:subject:to:to; s=mail; bh=RqaazN5MwSV5jN25f6JI+L5jWF8z9
	mV2n9cXiYMfDyg=; b=H/wj1Sz/BGB+zfpRkapo+9C2+kyX2krx7FMfXb6t9GeCE
	3fDHRHuKpMAcmk5n8U0nXsZm7Xa1jIsyEGE9A4X1A8+tYPV1IIkeS3erAmC01oQc
	po8Bc24hJqJ2qUixyL9P7ilY6H3jUbLmznvoACWspEnm7GgO4b0aNwBEB8+lJiHV
	QjUfVkB6WUWm3752qf5dpHzfvBPUA6vlGaG5ZMzdZbWiQEigvlXXo17yEmKzE0Qo
	3hSuLpgtEYcFpPBSW64xtDAKP1bNupCefVDvpiziUzFj5v2kVYeLFpD9CDpUj0p2
	aIgQaWV64IPhvrqv19cMjTbFotCX8tWW9beHWOXEJzsW37db9OEb1urg0ddPN9JN
	qZlL8zFdnzfNV2c/39BhUG+ozClPw5g36fN5DK0GJUfUUun/HNRjkzUyHZO0M1M7
	+5b4O/r3VQmbOyETpG9S6lqCQIuprUmrWZvcgE7Du9iAHbT6SCd9ECCyQlA6l5Su
	gY4rEY0b2mcWMONpqw9gXp6kLCJzDzuO7ym0qOpdzQpt/yPCV8EPN8ivmEmQr0cu
	qBfSWl1+/lJpEGJTNvSXtXYYT+gHzBetpx8QIt8qtf9JtY3OUxdIBf/mP7SThdTt
	rUmD4bUMzAIInJHoD/0Ig09IXhvltr1qaAEvkcTt6rZvMcx+HXiM5anHKuz6jM=
Message-ID: <51d368a3-fcfd-4f0f-9475-877739f19fb2@prolan.hu>
Date: Fri, 24 Jan 2025 11:50:37 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] Add more devm_ functions to simplify probe path in
 drivers/spi/atmel-quadspi.c
To: Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>, "Rafael J
 . Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek
	<pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Nicolas
 Ferre" <nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Tudor Ambarus <tudor.ambarus@linaro.org>, Varshini Rajendran
	<varshini.rajendran@microchip.com>, <linux-spi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <dmaengine@vger.kernel.org>,
	<linux-pm@vger.kernel.org>
References: <20250124085221.766303-4-csokas.bence@prolan.hu>
 <20250124-stumble-unpeeled-165f2211dcfb@thorsis.com>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <20250124-stumble-unpeeled-165f2211dcfb@thorsis.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94852677063

Hi,

On 2025. 01. 24. 10:08, Alexander Dahl wrote:
> You can pass '--base master' or '--base=auto' to `git format-patch`
> which adds a machine readable line to your patch or cover letter like
> this:
> 
> base-commit: bc8198dc7ebc492ec3e9fa1617dcdfbe98e73b17
> 
> This way tools can find out which commit your series was based on.
> See for reasoning:
> 
> https://people.kernel.org/monsieuricon/all-patches-must-include-base-commit-info

Thanks for the tip!

> I'll look into your patch series in February, after my holidays.

Hmm, if my calculations are correct, 6.14-rc1 comes out on 2nd Feb, so 
does that mean that this series will be pushed to -rc2? Then -rc1 will 
have the mismatched PM calls...

Bence


