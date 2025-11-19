Return-Path: <dmaengine+bounces-7251-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF1AC7136D
	for <lists+dmaengine@lfdr.de>; Wed, 19 Nov 2025 23:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 3DFF4291F2
	for <lists+dmaengine@lfdr.de>; Wed, 19 Nov 2025 22:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83562302CC3;
	Wed, 19 Nov 2025 22:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HL6RO35V"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D227127F01B
	for <dmaengine@vger.kernel.org>; Wed, 19 Nov 2025 22:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763589726; cv=none; b=FSRvfJblLQuFuThNWUCoovxfbscv7r6WFqySGkITsjrZusG6c2P+XcT4BeXPStKGnnAQ3YE6BVxM0B1DqUph1+yF9xCu2FBaqxHKgoT6hV5i9S9lud+2KFhoH44A6NVSyHiRAG0VnbnRvmopQL+Qu5hadBI9DOp0hlrnHD2NLyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763589726; c=relaxed/simple;
	bh=MMOCd6+pmZhKhYK3yL9W+pUiedqJaSbBe6IADG4ykIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fDf5Ls07RSgvuCmXmdUhLORt2WZxlXIroLiC4oTxZf6F5PPCrO4mClz49eTtrKkzyENL4T+l8YqM54qsjAGfepljFJ31WLHwcalVIiRmMSn0wRIdBlW+hoMtUPDDhePohIBaAcPwZP/2afRKxyfbbIecv1gzIjKDf6rnf8fcJXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HL6RO35V; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-431d65ad973so1251905ab.3
        for <dmaengine@vger.kernel.org>; Wed, 19 Nov 2025 14:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1763589724; x=1764194524; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y69g14VVZfoTlrhxJgLGJZ6gluiFhhzpz4/9gY8TxIU=;
        b=HL6RO35VkTXila4JC00dxjFDhEs/2yhAITk+oRTwIqKK0i2G0dOs21wWTHk9nKEL4P
         l/1rAunVY7QlzkRtVuJUCrPCBeIUZcufhbTSOYvA/bokaj2i2jbUMNII7fhCcowOKtbU
         /h79T1cHzZDtQFabVj+MsIsKKJOTKXLZLAn/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763589724; x=1764194524;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y69g14VVZfoTlrhxJgLGJZ6gluiFhhzpz4/9gY8TxIU=;
        b=Wm7K8LrL7Go7j50WM4G7dLcZ5+Wac+ppIwExn0r+PByAb7QXuTd3jJjyZMHAtWQP2o
         JfpgTdXKTz1rO4rZmpF4CS9+Nn3Viy/C5ol7nXpHF38QP5Q/QI2TdMJx5DEz9QwOAjLt
         Y9iVOgjKk7BlU5CgLVylS7SEXXExD/DXAGdfH9u692tfrBH0hkUnuM1ktcfALjsqlFXH
         Khue3FFlEZkUNQUuEDcO7FbXdMqNcp07HiFjA4XkB9GJ81XTDXO9QfPtCEps4Tin4d9p
         lhbsqKroo9chnPhnsfcl69NQPPXj2dudlB9vboCS/qoqnYSY6MhsqFhhJnYGvBSQp3Dv
         wQdQ==
X-Gm-Message-State: AOJu0YwBfBoewftek4qcOJx6I5a1IvwwcsfXs0oBL4N30dCbaCgTtnuj
	D4qaPkJdU6kZ3pDCfgWDlD+FLto4asmxKaVVtSlRXbUJHlfMPmmqDOccf0+RWGkg1jo=
X-Gm-Gg: ASbGnctRrmg+FUp1jjq/gsuJP6acv9ezjmVqYlBCjfdQDV0H7YQhs3nm5+UVvc09W0H
	e37tRzrudf5EHPmVncpwYEpQDq4V9X+hzG5ysifGUe/79rO0LhpwKlVA/+lB42laBt3RHNZ1dA1
	GPOc8wkghB7O1QVcnJLdzg7MsHUTd6Bgz7nAk1UMVwnlDVOBHEllMeblmj509s9XgEQxZNAy8o7
	w833Ov7o/jb1fXOpBWqXL/UUigbnW2/0RzxGQbKJY3wKGWF0zYuz3DpMgbXvSJYhfk+CvTybYUl
	mNJRtfbJxI77T22Ky0sPym4r01CpZqq8gV9a5UsmRYqDNf5kQ5Ti8yu+51lv5vwstgyQMmLv5to
	Q16bOz/kWCJYKf3/Yz0RSj3bgxYAM1IXvddpNeaB/9vv5nvSOOoTj2dZRAXtONuk0i5/64viXbN
	zKheVXX8+TBlOSBzTxIJSXp1c=
X-Google-Smtp-Source: AGHT+IGHtDnd+/05cJuQbIXypyVXpRrNNuziZo8lUC/Z43Rg9Fkp+rKdsOA2miYs+V4Cuy0Sr4EuTg==
X-Received: by 2002:a92:c266:0:b0:434:96ea:ff4d with SMTP id e9e14a558f8ab-435a9e22196mr5350095ab.38.1763589723888;
        Wed, 19 Nov 2025 14:02:03 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-435a9069247sm3163765ab.15.2025.11.19.14.02.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Nov 2025 14:02:02 -0800 (PST)
Message-ID: <3da29510-0441-4abd-aaa9-bd085844876b@linuxfoundation.org>
Date: Wed, 19 Nov 2025 15:02:01 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma_map_benchmark: fix incorrect array access in printf
To: Zhang Chujun <zhangchujun@cmss.chinamobile.com>
Cc: dmaengine@vger.kernel.org, linux-kselftest@vger.kernel.org,
 vkoul@kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <250fe2c8-eeef-4764-ad50-d5e5987fbd38@linuxfoundation.org>
 <20251107015604.2029-1-zhangchujun@cmss.chinamobile.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251107015604.2029-1-zhangchujun@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/6/25 18:55, Zhang Chujun wrote:
> On Tue, Nov 05, 2025 at 08:30:00PM +0800, Zhang Chujun wrote:
>> The printf statement attempts to print the DMA direction string using
>> the syntax 'dir[directions]', which is an invalid array access. The
>> variable 'dir' is an integer, and 'directions' is a char pointer array.
>> This incorrect syntax should be 'directions[dir]', using 'dir' as the
>> index into the 'directions' array. Fix this by correcting the array
>> access from 'dir[directions]' to 'directions[dir]'.
> 
> Hi Shuah,
> 
> Thanks for your patience.
> 
> I found this issue while carefully reading the code in
> `dma_map_benchmark.c`. The expression `dir[directions]` stood out because
> `dir` is an integer (enum or int), while `directions` is a string array —
> so using `dir` as the index into `directions` is the correct form.
> Although C allows `a[b]` and `b[a]` syntactically due to pointer arithmetic,
> in this context `dir[directions]` is logically wrong and would print an
> unexpected (likely garbage) string, since it treats the address of the
> string array as an array indexed by a small integer.
> 
> The compiler doesn’t warn because `dir[directions]` is technically valid
> C (equivalent to `*(directions + dir)`), but semantically it’s backwards
> and breaks the intended output.
> 

Applied to linux-kselftest next for Linux 6.19-rc1

thanks,
-- Shuah

