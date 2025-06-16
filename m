Return-Path: <dmaengine+bounces-5500-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C38A6ADBC62
	for <lists+dmaengine@lfdr.de>; Mon, 16 Jun 2025 23:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71CA016749A
	for <lists+dmaengine@lfdr.de>; Mon, 16 Jun 2025 21:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31A82206A6;
	Mon, 16 Jun 2025 21:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mx+QJq/Z"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8391448D5;
	Mon, 16 Jun 2025 21:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750111187; cv=none; b=WhesXjmOzcD2bz22XtxD04PYFFMHDs0WF6ZfgaldugbkWddDG5Vrk/jdq91fRv3J+XXT5NFr+Nx6nMZSyZhm5INujBpEnPIRPzAS74YAbE+Y01PoZB8yC/pPIWSuM7LFSIO8IdUVmxzzWHpXlnyx7urvaq8Q92uzkIOm6Bir+mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750111187; c=relaxed/simple;
	bh=dmVXtZDq1GpnBEuGT0uceXOef/ohgyxYRigN39A5qAg=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=rg5fzTYFdjNwDkgBcjC9Gd2khbri7yi/D0a7/dFUeWrdL5UjTaGtuRKYxCrs0ltV3w8iXtB0vS5YaW2dVrC7rq3rqEiHEpDj3zSpI7KnLKvYDRNKJDoQlyj+xWAJ5lX4O2jKbtevXNGKZzkja4q6V8LbOgAiUEVOihKyAtiO/rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mx+QJq/Z; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-31329098ae8so4362421a91.1;
        Mon, 16 Jun 2025 14:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750111186; x=1750715986; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dmVXtZDq1GpnBEuGT0uceXOef/ohgyxYRigN39A5qAg=;
        b=mx+QJq/Zm7DH+1NBZIyhQ1smtWKecQgkvnlVbl8wY1mazmEbFRzWaQbs14E7H31pxZ
         50cB0dYBp4VsU+YYoOk6ICTUM8nmE7imWT85znAnUL0+erM5CWad3TDUgMo2Hdn1b1tj
         X800t1zGk1QP+q4LF4KGizzI90sy+ygiXSgN7gyfvO9Se5LmZLIcW8Uu9v90pba0Xk/Q
         osUcXNlNI6/j10lZAWkmeo3M0Qnc49+WoIAQipTp0KtBWQ57c+Pa0kJBdR1so5XQA3Dz
         tCrpRhzUlvs0tmXvRVzeHyTQujEsAq2ENp/c+yxFpdmojGxapIfSFLgGAyag5Dd3Pilq
         s7yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750111186; x=1750715986;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dmVXtZDq1GpnBEuGT0uceXOef/ohgyxYRigN39A5qAg=;
        b=i4pkGC2mW3zFb9pQOYXfb8yns/x9PBRwJwKznMHhcvG7T8Ry7C78MRb5Ec+eWQPLZI
         ACcrfj8wbQy4t9VtmQchCA5VfiOP49IPb0B7gdwyxYu7W8IlDGrAtoKfo5iHRSR8yhBD
         4oIvjbCIoYl2Da7LiR5NNWd5eD6I6ADTxhzjbUGpjqvy+otQJU+qU6uRgDdLWOwqie1f
         k6jKBT+RYE+gOr9lo5LAw1yr0J8eVjt4DC2erX6J8qhOvqCpJtsR4J6HrXyCZNEpjuo8
         dUSELKf5iQH34akhHtizqybSl2AWoDS3sxDcWvu9JG4Y8387zFJ02DxrqIzNlUDWHtPz
         rDtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQl5DZa3Zv+y+7lb9Bvv7Ehd73wzMzdo3wz8RH2jlLjCxzJGgkmRonhb5NQOvXnNB36CTtoAy3FEY=@vger.kernel.org, AJvYcCWzvYnZEc97Sv+iShfgv3bdEPCwLGMsdzNxO3Qxfh2joA/DOaiOA87n+ReEzrl8hUURs2PkOAkkOh39biWg@vger.kernel.org, AJvYcCXP7LdwsH342IAgh+Jx9qbvbfRjs1cKz3a5WJ1eEuNE7jVjJqFYV8oYmClqY142hTJgAgS9qKcIRSr4/MF4eQ==@vger.kernel.org, AJvYcCXzZ6iUFc48x0TIsHJ32iR2raQ7AZn6YS6cKjA+W6/Dql91pPp7W0d1OnMC2Gl3Jzf/P/TEeRo8@vger.kernel.org
X-Gm-Message-State: AOJu0Yw19h5N5qmDZ9rCk2+/oBNfXl0hiJRaxdHWShgk02P02CEMQTLH
	y+0Abk+UdR5Boogjs2mfc0PcTfZesnqzEYKIuTe86D3YioNtqjgrlqBo
X-Gm-Gg: ASbGncvTgs95kvy3UqtrkqEtxE63bYzJYwhyzLDQUC/VZPZ/y36M14olTfIoFJ8h634
	1+4FbrDbINcVtbiDXOo74ghbgQiPJq15gDwxLjpKMV8mCzf2wR5j8piyazyfsGdGxGWxNbSaaU1
	u5GSydqQMVwJXHJJxW5c29JV4xFVXL9It9nCqFmzqs6GE6wEQ9pj7CTvcuhnhH4Hw2JD7gxO8XZ
	OGRXlTAYbtXb1FRnLWyxPYHkeIIn8uyQXT9icDejyVmX+QTa6TjjqQ6kgwIF1tF7+tFojNoVWyw
	9saVBiHmkD501y20ngNszDVHaE1DpyYmmV9LTiXuQgD5SpJavFJuOGPw4NOk0N1CVQ==
X-Google-Smtp-Source: AGHT+IH4wh9y8+17NNr6OsXro0iWKu8R34LNjAfr7G0A8dLv1PD8LHOCsQSVBTatYUghTPAmFqKHbw==
X-Received: by 2002:a17:90b:5603:b0:310:c8ec:4192 with SMTP id 98e67ed59e1d1-31427e9d73fmr267216a91.10.1750111185654;
        Mon, 16 Jun 2025 14:59:45 -0700 (PDT)
Received: from [10.0.2.172] ([70.37.26.34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313c1c5e2ebsm9155674a91.33.2025.06.16.14.59.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jun 2025 14:59:45 -0700 (PDT)
Sender: Sinan Kaya <franksinankaya@gmail.com>
From: Sinan Kaya <Okaya@kernel.org>
X-Google-Original-From: Sinan Kaya <okaya@kernel.org>
Message-ID: <9fb982e6-7184-410e-94d0-90836c2a9129@kernel.org>
Date: Mon, 16 Jun 2025 17:59:44 -0400
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dmaengine: qcom_hidma: fix handoff FIFO memory leak
 on driver removal
To: Qasim Ijaz <qasdev00@gmail.com>
Cc: Eugen Hristev <eugen.hristev@linaro.org>, Vinod Koul <vkoul@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250601224231.24317-1-qasdev00@gmail.com>
 <20250601224231.24317-3-qasdev00@gmail.com>
 <3c6513fe-83b3-4117-8df6-6f8c7eb07303@linaro.org>
 <7649f016-87f1-475d-8ff7-7608b14c5654@kernel.org>
 <aE8bu2woUe96DVo-@gmail.com>
Content-Language: en-US
In-Reply-To: <aE8bu2woUe96DVo-@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/15/2025 3:15 PM, Qasim Ijaz wrote:
> Thanks for reviewing the patch and for pointing out the correct
> shutdown ordering.
>
> If you’re both happy with it, I’ll send a v2 that calls
> tasklet_disable() before tasklet_kill(), then frees the handoff_fifo.
>
> Just let me know and I’ll resend.

Sure, please test it on a test kernel module before posting with a tasklet.

This should be straightforward to verify.


