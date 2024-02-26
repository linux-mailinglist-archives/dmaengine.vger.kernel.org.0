Return-Path: <dmaengine+bounces-1115-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4548673BD
	for <lists+dmaengine@lfdr.de>; Mon, 26 Feb 2024 12:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 650D01F2D885
	for <lists+dmaengine@lfdr.de>; Mon, 26 Feb 2024 11:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36651DA37;
	Mon, 26 Feb 2024 11:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FKOYLbUG"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F42E1D54B
	for <dmaengine@vger.kernel.org>; Mon, 26 Feb 2024 11:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708947956; cv=none; b=tO8gfQUYwidY098QdxCYeeKJCj+GmCaxQ8KbX1QJfaY4cmJhES8qnrbn1gxDacQa6mavXzkWVjwN394M1CNy1hdHryaOvL+kYYl3XKB4by4RfXtq1cm6fYzyGV2x9S3ZCvCoyShNGeD0RDvgzn2wjht+YcgwSgN3eXY9oIHOEUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708947956; c=relaxed/simple;
	bh=5QHOzDnr2fZFc8mJv/ASjvc4DZGcBtF/FA4nRGxtHbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LDxsquDWdYfZ+A7kyMLFtkJC6jY0oVrLltNonSMBfrmrJXOqbHY3f3x3EMbA48HFWS6osyhZWN2VrudAKASkihblVodekcaqzxE2RFR9j25sGDLI7Wyaz3c8dUeOicrEznqGSyPqkY/O/Fa3yYh9EIIg21fJvVj1+JAVW2H3u3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FKOYLbUG; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a431324e84cso117532766b.1
        for <dmaengine@vger.kernel.org>; Mon, 26 Feb 2024 03:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708947953; x=1709552753; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5QHOzDnr2fZFc8mJv/ASjvc4DZGcBtF/FA4nRGxtHbI=;
        b=FKOYLbUGDQbtXJBEJNWkNW9CH7hEMkO3rlzlqmmwRupvA1OSmmJQW2ZSXRnsgfGJW4
         PcfNfwhDOfLhYUfvoKU7heXXnV4uLJX4Rni6bOCazo0C8B6DxTqbvuTIHlh7CQcWvsW0
         PtAGR9Q+B/J8BLrp824TsctVBjs7BCTwbuewjrCWzD2DRvX0Q4fG2Obro2ViMV1O+vL1
         pvCK4gCs0AQJm9Exy5bT6ToG5xOodxBI2+GsEDvt3muGymAE5RNhmV6A0gCu+PIDWigB
         bu0RvujSON2hYeiZ/BRX+F4y788nj3HHVuq3TYQ1HntiKDEbqeFeMT6Wj3eDaOuREUI1
         gP7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708947953; x=1709552753;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5QHOzDnr2fZFc8mJv/ASjvc4DZGcBtF/FA4nRGxtHbI=;
        b=hqVinafJBnIhTu1JPl7tBHYbcPq+MXcF6TNKxSwX3D2cMzh09JVwsXtBKkMZd2vPzD
         DgnVRHSOnYIBv1Hvgpx8/PZeUzUalgviDrf+LP9ufKXFLPGlPlJEB/1lEmJTZUF3oSZa
         nkBS/MStB9L81DdxRll1VZNt47sprDArfWGS0WBdGhZklE4GmWD1qdOTXyIHYrRZgTtW
         jMKHMYNH/kV2IzAHhrvEiV+KYE19luJw7iiib01ckyLaeJwdkh3/FZVuovnsOdhwuXFf
         cUUunArClZ1cqK2tKnK6DfJLgp6RHFSEcrHSqS8+Fh7VEZWTFelSnlIzJlCmHacBusKv
         LRrw==
X-Forwarded-Encrypted: i=1; AJvYcCUCc53xuayRZ6lXZCklSKHh/LlM174k0ZvqlRWWXVL9IK4bcBZiWxnEZ01MPgxF6XlbYdkDgjbTh/1zOKpBSsp3PEdPxFUR0GKy
X-Gm-Message-State: AOJu0Yw8RSCbFRrfuiPDaYkVUdVkXyLQGQLJRYZ06xoFwa7Jx+vEt5oN
	3X+O98T+hr9gjEdDvM7PSvA7OZO1e4JyfR1JmrOWlQ6jc9QBSJWMeNiPvNfkpUw=
X-Google-Smtp-Source: AGHT+IH8TtND5SHe97VFjkocDpWlBzqqd8/3crqG9Nh3OaWBEP6nmhxYTZJXMwvAZhqQ56h19IStNQ==
X-Received: by 2002:a17:906:2419:b0:a3e:f7ae:49b6 with SMTP id z25-20020a170906241900b00a3ef7ae49b6mr4000009eja.49.1708947953323;
        Mon, 26 Feb 2024 03:45:53 -0800 (PST)
Received: from [192.168.0.173] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id vh12-20020a170907d38c00b00a3ee9305b02sm2337992ejc.20.2024.02.26.03.45.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 03:45:52 -0800 (PST)
Message-ID: <1d7b31a1-60c4-45b3-a7ae-a3a2c2e126a8@linaro.org>
Date: Mon, 26 Feb 2024 13:45:50 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Remove T Ambarus from few mchp entries
Content-Language: en-US
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: claudiu.beznea@tuxon.dev, nicolas.ferre@microchip.com,
 dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mtd@lists.infradead.org, linux-crypto@vger.kernel.org
References: <20240226094718.29104-1-tudor.ambarus@linaro.org>
 <20240226112132.22025454@xps-13>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20240226112132.22025454@xps-13>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 26.02.2024 12:21, Miquel Raynal wrote:
> Could we mark these entries orphaned instead of removing them?

ok, will send v2.

