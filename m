Return-Path: <dmaengine+bounces-3351-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB24699D938
	for <lists+dmaengine@lfdr.de>; Mon, 14 Oct 2024 23:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B628F1C217B1
	for <lists+dmaengine@lfdr.de>; Mon, 14 Oct 2024 21:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44EE81D1728;
	Mon, 14 Oct 2024 21:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r2tK3ENy"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763481AA7AF
	for <dmaengine@vger.kernel.org>; Mon, 14 Oct 2024 21:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728941815; cv=none; b=BLg2p44rYjP9joZGgNGa3wRkxNW6EarJue6Xy9zeLiZ9qFfR4SPw7nl0fwtZNLFvB7Oz9zklxyrJECBgTpkg/irr6PhTZpWkwYwAAWxwoomhyR9DlZTsaWD7rLe23VbtR6QxcCdKJ6U2kI1ZEBwtEQuLZtSo/tpx0/Z7Mh+3BE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728941815; c=relaxed/simple;
	bh=k4SFlVjh+uR65uwdgKDRqHhs8xqLl0Ct7TG7dQW52lw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=owXgy1YBnghiQLbReXoo24Kgdj1jiDB3Ak5APMqbrZUYZ98fVEPfN85L2JcdZH9Fupkje3GCHh0kaWCVC/h4c2gkmGn7AN3c30hqIk/7ZRuWQrcOMIBJ9YhsUiw/JoE1Cyj30+NKympoCypfhkDFGDnvuwQKFMoIfMBxFRxGWxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r2tK3ENy; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a99650da839so820261666b.2
        for <dmaengine@vger.kernel.org>; Mon, 14 Oct 2024 14:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728941812; x=1729546612; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aS5oHRHtEas82fi6dLQvcPoGTT6ij1fnB8J0TcYqkvo=;
        b=r2tK3ENyMKvhrCAi7B1+Nfz/vQgmfUumEGaeN64F7XDwtJdB1HlrbmkFbY55dup8lE
         E2dSqcbaVhJkNM5X8aJdgcQzUn3MST+uryw3S/Cqsh59egA1iVcGYsLH2ftMPsKYHELY
         f77S1/zYmf/Bkfet+eQuvx5FDvh1/mCy+kzXWlnIb8RKQqnlSoLjIC0Nz9UBkMHCX8eb
         BFDDBzQ6EMldAAzRYnJC5ylqzonKLkQHYbPlLBntZE3RBFiu4mzFglwJtlm9XCMb0kuN
         hNK15wK+5GoyUPXByKgdGyRBQ7SD/TqrSFeaAX7EeLI78LzVnFnqo2R4cMX57VdopjBO
         uhFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728941812; x=1729546612;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aS5oHRHtEas82fi6dLQvcPoGTT6ij1fnB8J0TcYqkvo=;
        b=uNp4zeeyXn5Gg5SWyv5C+JUbihyVxIpyH6aD1MepuKsZhk4IUrd+lURzftPlx54xKH
         fcVNMgVAGQJoWs/QY4cCJrMO4qDbaW9AFotUd5wW2fMOL4iof2vyL6ocVSKMktDYTbOL
         kDiAJAOC08ZouiTHWLD/PzKY4xa/ETX2uuAsjt5ZlaxJwR5NpK2x2qDc0oD9Y5A3Iatq
         +nO4AcexWgnx30aL4l0RXzvgrnt7MJjW6VnFTESjwTClUHvHzdsK8DBPiX6Tc/SwakyP
         Q1BZnTCQaFkzBZ8sdKXKX8y2/njTEx9SwpszzI8K0YN11zc4eEtx8icBxCt+6VNf5QBL
         /Evg==
X-Forwarded-Encrypted: i=1; AJvYcCVDN1vk5MdAsels/WiBIrrLLMu41+RGsveKNDTY4eGmnnuddYqTIDxXScir+M9Qe5TwcNZFY/ieMIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFbLMoFd8cmqU/Wxpe1pcuZkHsCKoMY3NsQTLzfEmrZa+CrQuk
	hniyYRb2i9/lGU4tEKb+9KzzcRzOJyYrRhUkd9q8Z6D6hWJNr1vUJYg1h2Xp3bA=
X-Google-Smtp-Source: AGHT+IGMbzqVMCN4nXkCJp0ZbA/DVg+/3LgMvva+vLk+OtvbPDG71diTtg6++8GyVXSdB/0w22sZkw==
X-Received: by 2002:a17:907:e2d0:b0:a7a:aa35:408c with SMTP id a640c23a62f3a-a99e39e4fbbmr856093066b.8.1728941811683;
        Mon, 14 Oct 2024 14:36:51 -0700 (PDT)
Received: from [192.168.0.40] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a06169946sm260451066b.204.2024.10.14.14.36.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 14:36:51 -0700 (PDT)
Message-ID: <6a060f86-82af-4d39-9ab8-a377650e6bf3@linaro.org>
Date: Mon, 14 Oct 2024 22:36:50 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] i2c: i2c-qcom-geni: Enable i2c controller sharing
 between two subsystems
To: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>,
 konrad.dybcio@linaro.org, andersson@kernel.org, andi.shyti@kernel.org,
 linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
 conor+dt@kernel.org, agross@kernel.org, devicetree@vger.kernel.org,
 vkoul@kernel.org, linux@treblig.org, dan.carpenter@linaro.org,
 Frank.Li@nxp.com, konradybcio@kernel.org, krzk+dt@kernel.org, robh@kernel.org
References: <20240927063108.2773304-1-quic_msavaliy@quicinc.com>
 <20240927063108.2773304-5-quic_msavaliy@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20240927063108.2773304-5-quic_msavaliy@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/09/2024 07:31, Mukesh Kumar Savaliya wrote:
> Add support to share I2C SE by two Subsystems in a mutually exclusive way.

As I read this the question jumps out "what is a subsystem" - in Linux 
speak subsystem is say a bus or a memory management method but, here 
what you really mean if I've understood the intent of this series is to 
share the serial engine between two different bus-masters or perhaps a 
better description is "system agent".

Please make that delination clear - its not two Linux subsystems but two 
different Qcom SoC bus masters right ?

For example the APSS - Application Specific Sub Subsystem - where Linux 
runs and say cDSP - the compute DSP on qcom SoCs.

I'd rename this patch to make that clear - because "between two 
subsystems" if you aren't intimately versed in qcom's architecture 
suggests that a Linux i2c and spi driver are somehow muxing pins ..

Really this is a type of AMP - asymmetric multi processing.

"i2c: i2c-qcom-geni: Enable i2c controller sharing between two different 
bus masters"

And I'd mention in the commit log specific examples - APSS yes we get 
but what is the other system agent in your use-case ?

A DSP ? Some other processor in the SoC ?

Anyway highlight one use-case for this AMP case, please.

---
bod





