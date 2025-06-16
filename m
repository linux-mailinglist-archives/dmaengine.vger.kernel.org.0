Return-Path: <dmaengine+bounces-5497-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5F2ADB556
	for <lists+dmaengine@lfdr.de>; Mon, 16 Jun 2025 17:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FF6C7AC1B8
	for <lists+dmaengine@lfdr.de>; Mon, 16 Jun 2025 15:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15C02206B8;
	Mon, 16 Jun 2025 15:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="ZB4DEg1i";
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="ZB4DEg1i"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail.mleia.com (mleia.com [178.79.152.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615AA21CC62;
	Mon, 16 Jun 2025 15:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.79.152.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750087564; cv=none; b=qD82+lmtWjkAKlpktsGtQ1p7m2PJtSpL2rkCq6jWc9csZ6TBAxv8RnRBGkyNcYMhCaCb8KzHs+WSjKiZSD8Q+1tcTnQXkIvtB+Y85Psc0EkNk16QYKdMiH9XpXKFKDV/0/uHhJm1RRqw3r9Bcvlun6cEvvpV1cakbuL2HiyG/3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750087564; c=relaxed/simple;
	bh=8492Hh9sftwBn41V1sCx1kh7fJYDsSQj3M1IUOmjNxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RyFg6r2FSX3G/CEffaaL5ojUtt7rv7yF6k/c27xU3VCLD4DA3a9PG+9KWzQlRoYqU3m/iZZZvgHQwKGBPBT+HNUxWAMr/sDCXr+OTS/wFtQbyXXdpM+1lcP4ZOW8Nob9imStVY95Kqgpg8ZpfODHhwqkIQCqKwSL3xzCdcPPECY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com; spf=none smtp.mailfrom=mleia.com; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=ZB4DEg1i; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=ZB4DEg1i; arc=none smtp.client-ip=178.79.152.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mleia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1750087561; bh=8492Hh9sftwBn41V1sCx1kh7fJYDsSQj3M1IUOmjNxw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZB4DEg1iyhX9hHcPY36NlJhyw7YR8EH+7MAMpzHLuVSr2OfkuimqdG96O2zlGiO1I
	 ddMWdM22PFvOHxF63O9ocYlBpzk8QFX6JC3H1qJbHJa9smFSjJ4gZyATUzoJCqTIrd
	 DmHVO8juXi5FKBQwVrpmmqxOrMbKYP5/wtFa2pwDLA+09AstzWNUrQyN9HvMKeWx0x
	 6MIkNUHjDgQYXGbwm3yNi9nM1HpsjTyHu7jXT011RKaW1kvJmTZEwcyBwvCve/2Rjz
	 9Gdjj2jiIBjC2gqD+iyATnMahCbd+nqvrpFRFgb6CU4/leFEC+BzcQG7ekvry4tt33
	 qFRTTMJQI3l9A==
Received: from mail.mleia.com (localhost [127.0.0.1])
	by mail.mleia.com (Postfix) with ESMTP id 9CDB93C2957;
	Mon, 16 Jun 2025 15:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1750087561; bh=8492Hh9sftwBn41V1sCx1kh7fJYDsSQj3M1IUOmjNxw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZB4DEg1iyhX9hHcPY36NlJhyw7YR8EH+7MAMpzHLuVSr2OfkuimqdG96O2zlGiO1I
	 ddMWdM22PFvOHxF63O9ocYlBpzk8QFX6JC3H1qJbHJa9smFSjJ4gZyATUzoJCqTIrd
	 DmHVO8juXi5FKBQwVrpmmqxOrMbKYP5/wtFa2pwDLA+09AstzWNUrQyN9HvMKeWx0x
	 6MIkNUHjDgQYXGbwm3yNi9nM1HpsjTyHu7jXT011RKaW1kvJmTZEwcyBwvCve/2Rjz
	 9Gdjj2jiIBjC2gqD+iyATnMahCbd+nqvrpFRFgb6CU4/leFEC+BzcQG7ekvry4tt33
	 qFRTTMJQI3l9A==
Message-ID: <335bf854-1a73-4370-93f4-77e9fd3febca@mleia.com>
Date: Mon, 16 Jun 2025 18:26:00 +0300
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: Add NULL check in lpc32xx_dmamux_reserve()
Content-Language: ru-RU
To: Charles Han <hanchunchao@inspur.com>, vkoul@kernel.org,
 piotr.wojtaszczyk@timesys.com
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250616104639.1935-1-hanchunchao@inspur.com>
From: Vladimir Zapolskiy <vz@mleia.com>
In-Reply-To: <20250616104639.1935-1-hanchunchao@inspur.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20250616_152601_656558_A4BAA7A1 
X-CRM114-Status: UNSURE (   8.94  )
X-CRM114-Notice: Please train this message. 

Hi Charles,

On 6/16/25 13:46, Charles Han wrote:
> The function of_find_device_by_node() may return NULL if the device
> node cannot be found or if CONFIG_OF is not defined, dereferencing

please see my comments provided for lpc18xx-dmamux.c driver, all of
them are applicable here as well.

There is no problem to be fixed, the change also shall be dropped
in my opinion.

> it without NULL check may lead to NULL dereference.
> Add a check to verify whether the return value is NULL.
> 
> Fixes: 5d318b595982 ("dmaengine: Add dma router for pl08x in LPC32XX SoC")
> Signed-off-by: Charles Han <hanchunchao@inspur.com>

--
Best wishes,
Vladimir

