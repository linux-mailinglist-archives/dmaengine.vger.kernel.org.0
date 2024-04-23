Return-Path: <dmaengine+bounces-1941-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D7C8AF3D0
	for <lists+dmaengine@lfdr.de>; Tue, 23 Apr 2024 18:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 434232880BB
	for <lists+dmaengine@lfdr.de>; Tue, 23 Apr 2024 16:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB0C13CF9F;
	Tue, 23 Apr 2024 16:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J9X85Q1S"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E6F13BACF
	for <dmaengine@vger.kernel.org>; Tue, 23 Apr 2024 16:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713889396; cv=none; b=BTwBEheg9K4kOQj1higw8flpDZSRV/zS2OsJbCWHLmcjN1wSwBkxWmEoXAjJhwf+ZUoEXmSPaLgbLtbvlqIurVwGTrDvcMAilY0Zu7XfPPtp7/J2hkOztAJKqACnkTLSv9y3ffxdRRnY2jcPvL0uYKWuy6PlQSGrxfhnhvWwjbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713889396; c=relaxed/simple;
	bh=di3fBEWaf3r4JLUJjdiQ27NJdTUJM55Vizjr1hVxt4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CbG+9YUPv9jkmI0z3X03dMwo5XE6h6BCu/mJq3YSHuzzzcuH4tks7XWQy9OWYL8ka5oTDEEOc5OmvbUj4ow0ZHGR9tktPGbRrd87p/BfAMJh1G8CU3b1BSUTxVZVGJRiaaEW5/D08L4LkkCwLQKCkPT97D60iqOi+RTXDWKfJKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J9X85Q1S; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2db6f5977e1so78375131fa.2
        for <dmaengine@vger.kernel.org>; Tue, 23 Apr 2024 09:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713889393; x=1714494193; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eV3JYQjvg7ps2tDw1BUY+qYafvfWNiGj6kHpWXZPB7M=;
        b=J9X85Q1SCGqjEgx8+ytKq+l3Fo4gRU3extrqVg/EW4ZS21Rpr5MRa6dQwBqbzkxGHp
         Pb4cePJpPECjcoq/mwbAP/O205/5qwcdpgbKPhejLW+3K2FfafmTh+hHGn1KhnDGlaQ4
         gUorWi71SkrjvuXSsK/KzFFmHiTGb9obhZkCTmefBetw3afqTKy3cNApoEoqd31KzOhS
         TOnKce16VYlxdc2qjx0tUn0e2jtYj3zYku50FU4+UgBQXl7LfvmHCuXTvTN8gTLaf7bb
         AEYoj4rjxsVPkr23ezYdWxxPgNcW3a84/neDEpix4vlRIHOg7mzH/Tj9xRLPRimIWurh
         qssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713889393; x=1714494193;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eV3JYQjvg7ps2tDw1BUY+qYafvfWNiGj6kHpWXZPB7M=;
        b=ldzOhZxQK1aLJwPE9GHwuZgfB/luqbi3yTN8AUO+6JiTnHcA0CH6QWg8WcCCb9IWXD
         H3lXvKgyz+NrtMp9O9JbJeLr0SVsyTki93gub0VJvuuy5YRzkTxXVLXCnJjXx5pcVzwd
         7lzcOTNZJjrNR0pcOFMDYDwYFjYxq2Lu6GdyDww8wzSnJX2egwII5tzoHwewP4FN3Rbx
         rZPZ+t2gNfBFcTk/aHmPgAbEbC5DBA94j/a5e/QDtTeVX8xUh5z/yfmwNE9+AxpbY2Br
         K9XEHlk3Mt94qZEagNcFnDbgnsuZjY35HRCw1FGjzFC1JKzU+laDV8zx2XAb9d426EXK
         rTfg==
X-Forwarded-Encrypted: i=1; AJvYcCXtZ5Yuz+dBIsoWh8owYHUQGPajVFATHmRCnQmRv10XRRCVULeZ34UGbxkDNmXgqLx9sTjfcQqavdpyCdVAMoqV6/IVQvNLyGcD
X-Gm-Message-State: AOJu0YyQTMBm5OdRIQrv/qCaDpvMQnQ6wSdjZdYA6bQUWti/JJieXN7n
	Axsb5TsUVdOgcLBxGRVDXDohvvGylaO87rqqpSONMisfXMw6douCN0UNgwDLXXg=
X-Google-Smtp-Source: AGHT+IG6D6t4oovl9EKg9UPxHrmD6SGFGORMtpSatzoOpPt6wgyrSwG5hvAvInKw3kGGJ2qbs5jrQw==
X-Received: by 2002:a2e:834b:0:b0:2d8:7363:ff36 with SMTP id l11-20020a2e834b000000b002d87363ff36mr7848169ljh.37.1713889393341;
        Tue, 23 Apr 2024 09:23:13 -0700 (PDT)
Received: from [172.30.205.0] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id u15-20020a2e854f000000b002db706ec5f7sm1735182ljj.98.2024.04.23.09.23.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 09:23:13 -0700 (PDT)
Message-ID: <2efd6856-0e20-4b0f-93d3-60926ba2e4f3@linaro.org>
Date: Tue, 23 Apr 2024 18:23:08 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dmaengine: qcom: Drop hidma DT support
To: "Rob Herring (Arm)" <robh@kernel.org>, Sinan Kaya <okaya@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240423161413.481670-1-robh@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240423161413.481670-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/23/24 18:14, Rob Herring (Arm) wrote:
> The DT support in hidma has been broken since commit 37fa4905d22a
> ("dmaengine: qcom_hidma: simplify DT resource parsing") in 2018. The
> issue is the of_address_to_resource() calls bail out on success rather
> than failure. This driver is for a defunct QCom server platform where
> DT use was limited to start with. As it seems no one has noticed the
> breakage, just remove the DT support altogether.
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

