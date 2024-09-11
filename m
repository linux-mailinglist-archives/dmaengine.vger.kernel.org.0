Return-Path: <dmaengine+bounces-3143-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A4597591F
	for <lists+dmaengine@lfdr.de>; Wed, 11 Sep 2024 19:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA6CC1C23513
	for <lists+dmaengine@lfdr.de>; Wed, 11 Sep 2024 17:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBBB1AC8A6;
	Wed, 11 Sep 2024 17:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eO2RmY19"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02FA58AC4
	for <dmaengine@vger.kernel.org>; Wed, 11 Sep 2024 17:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726074943; cv=none; b=MajRJq9/xouMYhocaYqNsBR9WntyZuABHWD66q8WMdNf6ejz3A8eM05S/5qOfW+imXpuTFu68STfvRIO1vpTz2cVDD1Xm+fTglYS7QfBa2RxSDO9/eyzSySjjJMtOGVbUKNcCGLhpJweo4yeZttUmyUsoffrmqo/CMKWy/sUbVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726074943; c=relaxed/simple;
	bh=gKSJcWcx7/FQZ2m0mQH0VM1o1ZdEvOQ4khTHZUPZj0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F7tq9KKzl7GnsOZNmfmCRzp2t20HlKpKVj+cNeT/xJRJjcEa73OXTv37r61+kMyoz9gECx1f2qe7IH8V6Qmgp9R9oQabNZSIRgJMRg6b38L3AfGsbOpLth5b8Q3TFyjBNzaJY9pWGlJyaYT+UfAtJ2sPPe6SY8B3LTdOP5c+CDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eO2RmY19; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-374cacf18b1so61585f8f.2
        for <dmaengine@vger.kernel.org>; Wed, 11 Sep 2024 10:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726074940; x=1726679740; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7hIkqY6yzMI19aPeRgJcYOawca4yCAFYgaDnXopqdZw=;
        b=eO2RmY19Wwb90cmwTy1uXwIv0RIAV+JI5M2nKyExKJbeO3+1ez3Yeud9Y7Wzb+lqeL
         EpPoekWJ+u3RYgddgZ1jZNInA2WZ3gZ1RQQBH/soBW1QMa5F3TLTeorb4NqVewY0Jr1q
         61DWBZ1aIqgXGvvY238nwuOrNdd5FVaE27yAJpjYKpdSpBGwmgMPUPC7yOb2C5dM6Ai4
         iWx2879ACyePrnQI/O9qqQlGiJTwBGXeH4BZa8NrAv98lmleou20jNQ7UMPf5x/sGZcm
         vkXPnM8dt7VFkuZ995GzezZhtPhOzhZ9zZuKfozxulyY2f8M2GEFZoLVo19siCMqdcgt
         zylQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726074940; x=1726679740;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7hIkqY6yzMI19aPeRgJcYOawca4yCAFYgaDnXopqdZw=;
        b=ZOLERh4XZDvkzSTduNmfGm/XFcdl7DTTntRyjVuzB1cvpR4EtM9CdMd2m6ovQRNeOG
         Wdl94b3Pv3Tf18l43bzYAndBopUgFDJh6vWyuFgrgkXWjcu6MfmR2UNDk5xPwOH81jPW
         57skFP5mE3yI2TVFDCtoAXHRmD99c9GqNHQD+9tA2Fje+eSe02/MzyL261KOvHCXTuXE
         txg2LLmiKZWmT/zR7LZOmhVP4/6ez5THaO8XmZlxn7/fSWbzUKpatcVt/dXdqAZC05gr
         YQJjC9bvluAIX+YWXMi94wUG7XlX9K0Vgf99cQw0WKZ2o1wSL/kj2MSpX7l2rq5mIO+D
         Hx5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXaxHKMoZMMWouITXgYYGSW6UneDUZ81St/zhzFEp1RxLpV4ftMcYac3M0W+etWKYNRo8eR04Pk7+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmkCYpzO9KpwT2JfEGt9oJXoETcFLX37LDzxvInqUwU+08U3TC
	COjr4BQXwZk0Z04Hd4EN4UgS8L9gKLP8+IAF9LrMNvEsQjLyr0GLHcW4ZEjGyxs=
X-Google-Smtp-Source: AGHT+IFwsGFDDcYLdQbQDbnH2ecaEuRN6fTPY6e7kQA/Klr6JIoXz9qoW0zDvWsGSBZmy4CX8Oxabg==
X-Received: by 2002:a05:6000:124b:b0:374:c942:a6b4 with SMTP id ffacd0b85a97d-3789268ee7amr8782092f8f.20.1726074940059;
        Wed, 11 Sep 2024 10:15:40 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3789564a340sm12072218f8f.24.2024.09.11.10.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 10:15:39 -0700 (PDT)
Date: Wed, 11 Sep 2024 20:15:36 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>,
	konrad.dybcio@linaro.org, andersson@kernel.org,
	andi.shyti@kernel.org, linux-arm-msm@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-i2c@vger.kernel.org, conor+dt@kernel.org, agross@kernel.org,
	devicetree@vger.kernel.org, linux@treblig.org, Frank.Li@nxp.com,
	konradybcio@kernel.org
Subject: Re: [PATCH v2 0/4] Enable shared SE support over I2C
Message-ID: <ddb6143c-1dab-4397-817a-32015984ff55@stanley.mountain>
References: <20240906191410.4104243-1-quic_msavaliy@quicinc.com>
 <ZuHNJl7VvMSv8q8l@vaman>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZuHNJl7VvMSv8q8l@vaman>

On Wed, Sep 11, 2024 at 10:32:30PM +0530, Vinod Koul wrote:
> On 07-09-24, 00:44, Mukesh Kumar Savaliya wrote:
> > This Series adds support to share QUP (Qualcomm Unified peripheral)
> > based I2C SE (Serial Engine) controller between two subsystems.
> > Each subsystem should have its own dedicated GPII (General Purpose -
> > Interface Instance) acting as pipe between SE and GSI (Generic SW -
> > Interface) DMA HW engine.
> > 
> > Subsystem must acquire Lock over the SE so that it gets uninterrupted
> > control till it unlocks the SE. It also makes sure the commonly shared
> > TLMM GPIOs are not touched which can impact other subsystem or cause
> > any interruption. Generally, GPIOs are being unconfigured during
> > suspend time.
> > 
> > GSI DMA engine is capable to perform requested transfer operations
> > from any of the I2C client in a seamless way and its transparent to
> > the subsystems. Make sure to enable “qcom,shared-se” flag only while
> > enabling this feature. I2C client should add in its respective parent
> > node.
> > 
> > Example : 
> > Two clients from different SS can share an I2C SE for same slave device
> > OR their owned slave devices.
> > Assume I2C Slave EEPROM device connected with I2C controller.
> > Each client from ADSP SS and APPS Linux SS can perform i2c transactions.
> > This gets serialized by lock TRE + DMA Transfers + Unlock TRE at HW level.
> 
> Where is the rest of the series, I see only this cover letter??
> 

Something went wrong sending the series.  Here is the resend:
https://lore.kernel.org/all/20240906191438.4104329-1-quic_msavaliy@quicinc.com/

regards,
dan carpenter


