Return-Path: <dmaengine+bounces-1806-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D66289F246
	for <lists+dmaengine@lfdr.de>; Wed, 10 Apr 2024 14:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56C21286A05
	for <lists+dmaengine@lfdr.de>; Wed, 10 Apr 2024 12:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3DC15B996;
	Wed, 10 Apr 2024 12:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fEVePMLI"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737BD15B14C
	for <dmaengine@vger.kernel.org>; Wed, 10 Apr 2024 12:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712752197; cv=none; b=K/M3zBqqRhDqt7eWQimTb5h/55LjFnfasKBfvj1J9BvGyfjSKVeGBSIgRfOtdlfgTIpS5Ponrih51sSo4THZQk+PdoVU9k54mVBmH41CwBYCjdrwrA4n1tsLn3pbqFIf0dZlvE26xrHFJ6iKqfFuTaHQTJZLBeP/yDuFZLJNGnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712752197; c=relaxed/simple;
	bh=jsN9p5AlR+y/siVRTqak+eX0XeoQHzzHsK6bvZnvJzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gekww1Iim275XMwXBv5I2Y8IMfuO60P4K/JX1fDY8SRBjEAt8tyDPMV3Gf04yU4+EeuaGOX7f4I5lNFtkPVqByAwdT7gKGm5VXp6C3rtABOucdIXq4LvgbT47wXnnyHSubjbrKzIrJ5MJ+7GNwm6c0h/bXSeQm95fDxq/rEIBPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fEVePMLI; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-516b6e75dc3so8484148e87.3
        for <dmaengine@vger.kernel.org>; Wed, 10 Apr 2024 05:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712752192; x=1713356992; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D4Ncc1pa9BhF/FmRU7MOCEHKlQToJMxwytJIdFX92GU=;
        b=fEVePMLIyeene1JHX4gbixDAC3bntmUu1Bte/e+xEGmGH2qmi5pbp00RqlZ3mRU9yJ
         ZPNnBmT7Lj85bwcyrvfEuDylzMtFE5ZNLdv8MuJPCGA+koLz0HA/vtewHXIvzdhr0W1U
         efUASk3ulPf0cY4n8OjthmoSUtxM01OXuFzDCDItyonty9iaS9Rj5T8cgrWmH8rnhK9M
         DZiK/BmBAO2R+tXEjaHW7Hdp2/01FSoGDhMBnCe34Plyhf7Ime+C9eR5vLPTWhaBeibb
         kbIITk8KpqFFr1rSrbo2ACCQYGn2fg4SE3jsmiBolHAt0QNNHH4Gba7XaEhomsEFnExh
         2XYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712752192; x=1713356992;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D4Ncc1pa9BhF/FmRU7MOCEHKlQToJMxwytJIdFX92GU=;
        b=H4XazdrtgcJojvlN9JiruMSkX8/DHjs/IssZWNPgxM/JAmNmBv4Hq3AdufqUM4eVvu
         4UhsS9+Iid8Zbk45pKomaBsZcThuKdORyo5sgZoNUSSrIgyjLglQ5AAAEERUKtyLCbLs
         iydb9TuHbsJGX5ascl+b2FP4vmDQVJrUT0NqPXyuShwSCT4PVXIpZCxRmPaAINOOXu6J
         AC5NdtCGfbBA9WUQIaAnHnfixl8ThA+YjI2NYp0H8wGctycNx1LQOVZpbtc/gv3jpVfi
         HyJ14hj7Hx6hMkXx3QiZT16o9FegY16skCiyMEjZxjOHJYCIvhrgmNJAiXe1iQKaUWUi
         a2zQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAjL9mr1E7RyzduWp+oNV3pvOGejoXOz1EDwOe4/lvrpLId0BdjJyF/wW5cYqb/kuUrocWpmtuESqrHrBBzWuTZz5w62r5n3pD
X-Gm-Message-State: AOJu0YwBOYKiWCnzsTWvRc91AF4RIFtGDOQACsfxs7wtxSjJxi5Jk3TN
	cqpN8FVt09jJNdQrcmYLH7vT8r2c17lhj4yj3hRnGaXxLtOV52bjiVc7Qt7RjGE=
X-Google-Smtp-Source: AGHT+IEMQ8yZcBd4TMTcDIHC4w5kKEvGp3wOrZJ5atQgv3G0eOB1/cKSYlnMjP0jx9wJbqFfa1cWlg==
X-Received: by 2002:ac2:4d08:0:b0:513:dae2:dd7e with SMTP id r8-20020ac24d08000000b00513dae2dd7emr1430092lfi.32.1712752192622;
        Wed, 10 Apr 2024 05:29:52 -0700 (PDT)
Received: from [172.30.204.89] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id q7-20020a05651232a700b00515d106fec5sm1838458lfe.283.2024.04.10.05.29.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 05:29:52 -0700 (PDT)
Message-ID: <f565a3ae-f46b-46ef-ab6f-2d4fb645a4ec@linaro.org>
Date: Wed, 10 Apr 2024 14:29:50 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] i2c: i2c-qcom-geni: Add support to share an I2C SE
 from two subsystem
To: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>, andersson@kernel.org,
 andi.shyti@kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
 dmaengine@vger.kernel.org
Cc: quic_vdadhani@quicinc.com, Vinod Koul <vkoul@kernel.org>
References: <20240402062131.9836-1-quic_msavaliy@quicinc.com>
 <51c84af2-73f7-4af4-8676-2276b6c7786d@linaro.org>
 <669b516a-74c7-445a-b151-5463fe39b21b@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <669b516a-74c7-445a-b151-5463fe39b21b@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/3/24 07:56, Mukesh Kumar Savaliya wrote:
> Thanks Konrad. I understood.
> 
> On 4/2/2024 7:54 PM, Konrad Dybcio wrote:
>> On 2.04.2024 8:21 AM, Mukesh Kumar Savaliya wrote:
>>> Add feature to share an I2C serial engine between two subsystems(SS) so
>>> that individual clients from different subsystems can access the same bus.
>>> For example single i2c slave device can be accessed by Client driver from
>>> APPS OR modem subsystem image. Same way we can have slave being accessed
>>> between APPS and TZ subsystems.
>>>
>>> This is possible in GSI mode where driver queues the TREs with required
>>> descriptors and ensures to execute TREs in an mutually exclusive way.
>>> Issue a "Lock TRE" command at the start of the transfer and an "Unlock TRE"
>>> command at the end of the transfer. This prevents other subsystems from
>>> concurrently performing DMA transfers and avoids disturbance to data path.
>>> Change MAX_TRE macro to 5 from 3 because of these two additional TREs.
>>>
>>> Since the GPIOs are also shared for the i2c bus, do not touch GPIO
>>> configuration while going to runtime suspend and only turn off the
>>> clocks. This will allow other SS to continue to transfer the data.
>>>
>>> This feature needs to be controlled by DTSI flag to make it flexible
>>> based on the usecase, hence during probe check the same from i2c driver.
>>>
>>> Export function geni_se_clks_off() to call explicitly instead of
>>> geni_se_resources_off() to not modify TLMM configuration as other SS might
>>> perform the transfer while APPS SS can go to sleep.
>>>
>>> Signed-off-by: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
>>> ---
>>> v1 -> v2:
>>> - Addressed review comments.
>>
>> The biggest one ("too many changes across the board") is still not
>> addressed and the patch will not be further reviewed until that is done.
>>
>> Each subsystem has different owners and each change requires an explanation
>> (maintainers always "expect your patch to be wrong" and you need to
>> convince them otherwise through commit messages)
>>
> Sure, I got it. Will send patch dividing logically between i2c, dma.
> I have already responded in just previous Mail to seek clarity as below.
> It was :
> "Please correct me if this is wrong. The overall change is for i2c in GSI DMA mode. This also requires changes in resource control like TLMM changes. But it's more like integrated feature.
> Are you suggesting to make 3 sub-patches under same change ? "

Yes, every subsequent patch can only introduce changes to one subsystem/
driver and can not depend on the next patches (i.e. the order matters)

Konrad

