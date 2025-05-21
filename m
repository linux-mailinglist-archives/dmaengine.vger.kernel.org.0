Return-Path: <dmaengine+bounces-5229-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F979ABEC9A
	for <lists+dmaengine@lfdr.de>; Wed, 21 May 2025 09:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF5E41711BD
	for <lists+dmaengine@lfdr.de>; Wed, 21 May 2025 07:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C843E22B59D;
	Wed, 21 May 2025 07:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="tbqsNC0g"
X-Original-To: dmaengine@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7712B9A9;
	Wed, 21 May 2025 07:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747810894; cv=none; b=QOd0wJg9U79mUH7u2pt38ju4mFA0n8KikB2xbprm6+NUkfX2HiZb2UQMoj9EX6TNRbyWprr+hL24elZyo6YsWZRVyRVo5easCzVKuL95EpWejXXyOAtK4KeU030TPCQOv1gF1Y6DNuP11yxc4Ts7JIa0kXCnWcIOSciaJjzoQAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747810894; c=relaxed/simple;
	bh=Lt9CYMW02DOzhxDa6Rug1d76eG/C37B/SYIOvEnt+1c=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=NrXzjt7K/cJkqtycxRUmYQnRQ8JbdtMT3QBJ0NgD9vfCZVSXwMsj9JP8FLxg908EHnogO+FER659bu4pyhAI6qDCHj14KeCLUyrmvA0MiR68lkBVcXVOixdAkkXH04zPcxscYlvh00/4/4XC6K65qPTZOzdTmngX3llobRuUpZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=tbqsNC0g; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 30B8FA0F32;
	Wed, 21 May 2025 09:01:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=2QiAvvm3mFGO7j5haJ/C
	RUWWnyjSWWlUqQr8DQ5A31A=; b=tbqsNC0g1PX0U/IumfDoDbGPVXK3kUuNSOfS
	NTGoAORLsuXfvB1x6Bui/CjmuHNWeGpjlizFaeRKtTghJOuut/KXSK2VROeEVdUy
	N+LUPci3lsBvJyxSr4RGgQ62mOXkVwYfT8h9q52evCcTuSuZoBe2SFye1zEpkP9A
	3BjAGPE06GAv77PTT9hcEwKzuxi9QIgFEjUYAP3W27rTEvcmPWtu7AOEzwPR9OKH
	lEkDatJbfEsuMZaihHMEVnNqIcVfUxgNmJLbljG6MzZ2CDDmgsHsWCC8/qUG3r7c
	4a+h1duVe107lZh2JQQj31AxnBnH+/Bq/WC8sJHwGoRGaOkh7tumHXecPzNYCxzH
	5uLQiloaCL4RC0nsmoUIUpVJW1VaPwYTLfagRbav+qrtzhybtxtr3BK8p4RmbdGw
	ykKHdvbYjoDoQjBogYGO8C8nGJPi8Gw6CAUsX6iHisIByZvPDQNhhfi61nxgLQ4b
	fSUtgZoTuICW/171rTCZfgWaaI0CpoFW+jCF/lpI3xwa9GfusY0sLfKtsPtT2sZr
	UcwxLwvSOBudjQNBTOL5UBvjaACTAIoRFAn4lZ3cCij9/F+lVK85mCIlmIGGvTDe
	XV+iSxG/tmJdwFALKyCwycszjZzFWvOZKhfOlkoiGQHShEo1tiCAugsyXhqP17Nr
	nL6BCw0=
Message-ID: <6a7ffc24-dba0-4b67-9d3d-477f3bdf2128@prolan.hu>
Date: Wed, 21 May 2025 09:01:14 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
Subject: Re: [PATCH v9] dma-engine: sun4i: Simplify error handling in probe()
To: <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
	Chen-Yu Tsai <wens@csie.org>, Julian Calaby <julian.calaby@gmail.com>, "Vinod
 Koul" <vkoul@kernel.org>, Samuel Holland <samuel@sholland.org>
References: <20250514161803.229600-1-csokas.bence@prolan.hu>
Content-Language: en-US
In-Reply-To: <20250514161803.229600-1-csokas.bence@prolan.hu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: sinope.intranet.prolan.hu (10.254.0.237) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A296767155D607466

Hi,

On 2025. 05. 14. 18:18, Bence Csókás wrote:
> Clean up error handling by using devm functions and dev_err_probe(). This
> should make it easier to add new code, as we can eliminate the "goto
> ladder" in sun4i_dma_probe().
> 
> Suggested-by: Chen-Yu Tsai <wens@kernel.org>
> Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> Acked-by: Chen-Yu Tsai <wens@csie.org>
> Reviewed-by: Julian Calaby <julian.calaby@gmail.com>
> Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
> ---

So, can this be merged? I do believe we have ACKs from most maintainers.

Bence


