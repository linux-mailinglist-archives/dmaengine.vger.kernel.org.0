Return-Path: <dmaengine+bounces-4310-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F012A2951C
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2025 16:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E6673A1791
	for <lists+dmaengine@lfdr.de>; Wed,  5 Feb 2025 15:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DAC917C224;
	Wed,  5 Feb 2025 15:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HdQakbt6"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF375B211
	for <dmaengine@vger.kernel.org>; Wed,  5 Feb 2025 15:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738769872; cv=none; b=natG9H5+Z+/THFZZeHNcpd60zph18C7jUXa1CXNFobclBBkTK5WP6bDK62I2FuxLYNNixYhzj61Vbw0M9KPnBEgOc3Hh9Kuet8a9BcoE9fXmTHj5JKwwv+A9C5p69VfQYy4LsRDMU7DteWv+91txmksj9qEh7B2iDEPLQtLQfLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738769872; c=relaxed/simple;
	bh=9L1QGlbJh4WY4sEcjNiiWTatr4uX/44EQsPNfcxNP88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cOG38BLC17/LiXv2XnityTEKW1AbyO86AMB9yVDdwIJDkMdMz8G1MiOgkfpp/J7XRJt99yWaTHw26aQoDKUj+jvefHnh7IzeSI3PmfULPU7dOjFqwCl8UpRydzxm4B1OnUFKDofQOhn0txOQvLllAkiB5LZ92u9vVrZ8sbIfm0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HdQakbt6; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21661be2c2dso118380185ad.1
        for <dmaengine@vger.kernel.org>; Wed, 05 Feb 2025 07:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738769870; x=1739374670; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S5GMWW/WHgfd+n4zB50D6s7SU2JvnxRhIweS+yznRTU=;
        b=HdQakbt641yNmi/+1k7mKHR6fOHTJ1OJEa/siAlAYTYaObEBBryWC08wLeSX4VLo7U
         8Wd2lH+iZI+ZMiYZ+Z5fkpLY/GJtbjLKjEp3kmnH3ee15f7rgAut7IqwyHf3/pSr9MAu
         wFz3J7+2e25c5u6n0F2nZZXcJmfkw4itmpj1MO669Hc6uB5kHkljG5BCzPWxawbPa0ds
         lSFm78hSWxEtWxhz6fHBSnH2GvDn2oVpu6dioEEps1sO0MNCgSLjpwzByNAOmWMSAhjq
         UycvMvHHpI1+KVITXNyVlP0GiofG3PU9lHB56zui1/6E6WpsJ21s/Q897jH9yYrg0z+0
         7++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738769870; x=1739374670;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S5GMWW/WHgfd+n4zB50D6s7SU2JvnxRhIweS+yznRTU=;
        b=J238vgIh9izluGsKXsO80/8H0oJNCWRArjV6IFFQ4i9wkcUfW6eKU/EADiHNdLsayD
         dHXrZ/tJLVWwbuYrqOZo+74Ha0Vl5d0nwC6DIJsV9Bb60UyAjs37vazTkGTVvOtgcvbn
         pu+M5C1RmT4pUAzNRezzCLeYLUs4mTs0/dvJ5zOW8ZR6i2IWuBH+loVdPH0GQCeWNXns
         OmVgrHKDWx/qSGcIMevkUZRUFEh3L/pol1QweBFgM3/6Z2LlufevKoHmhW/0KsubZF7X
         jh5xEXonNrjIL7QKrOXqu9Urg7gYmbcsXtduHNKLN/CPYSrfUh1Ws1nk0how4z4IXW4W
         O4JA==
X-Forwarded-Encrypted: i=1; AJvYcCXR+MwmXCBndwIbhntYZtxEy9cNcPpzfV4btGEHAI+VHUm2uF6G7MnCF5xX8kIdi44w9Z3b1yC8eyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLouvW5jCtOP6bIvI+rpZqsx+rl/7ddPaN7DpP+avKG273ycdA
	zPC4WdQt04EiTLxQhedtzJUg6TLZpApSG8hQNzzi+Y0kNuWEdbad//UAaixZemk=
X-Gm-Gg: ASbGncueTf+qb41uBDMyEK8HWYiS+9i/z78EKm/3EkwIlqEkE/ypdFlh4P97ozBykPJ
	v3cFQ4nNOTJpQe8S/KcZCCCvuG7cC6Q07NHppq7z3BBPa7E49PDW8TZoJWfxIkKawwQ1LohxZtZ
	ZkN9G3nbkrnhlAqVsiQ4m/SZY6KcRf3dB1nWKJAWNNe/EoHtoXW1Fg0tUIutzzXele3DxQa1fVb
	CX7YtKWMZY+BLwyF7uHgRnT5EVHzifHarriVlBoSQrAzdAHLDVJnUTp/7nHWqrQnnQ24NvmF/HL
	p4Td/LFUAMD+NvS8aQ==
X-Google-Smtp-Source: AGHT+IF4C/g5tls1Fv/Oo93D/Eb0Rphct6uCI5wuyLqIdTAYDuKgNBS/oYL43ivTaMRV8tDecHZsaA==
X-Received: by 2002:a05:6a00:3a13:b0:72f:d7ce:5003 with SMTP id d2e1a72fcca58-730351ec970mr5210315b3a.22.1738769869540;
        Wed, 05 Feb 2025 07:37:49 -0800 (PST)
Received: from localhost ([122.172.84.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe6424facsm12685358b3a.39.2025.02.05.07.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 07:37:49 -0800 (PST)
Date: Wed, 5 Feb 2025 21:07:46 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vinod Koul <vkoul@kernel.org>, Serge Semin <fancer.lancer@gmail.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	Viresh Kumar <vireshk@kernel.org>
Subject: Re: [PATCH v2 1/1] dmaengine: dw: Switch to LATE_SIMPLE_DEV_PM_OPS()
Message-ID: <20250205153746.e5wkwm6iromxxqta@vireshk-i7>
References: <20250205150701.893083-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205150701.893083-1-andriy.shevchenko@linux.intel.com>

On 05-02-25, 17:06, Andy Shevchenko wrote:
> SET_LATE_SYSTEM_SLEEP_PM_OPS is deprecated, replace it with
> LATE_SYSTEM_SLEEP_PM_OPS() and use pm_sleep_ptr() for setting
> the driver's pm routines. We can now remove the ifdeffery
> in the suspend and resume functions.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

