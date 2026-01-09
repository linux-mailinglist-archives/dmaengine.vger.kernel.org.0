Return-Path: <dmaengine+bounces-8160-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD788D0AF70
	for <lists+dmaengine@lfdr.de>; Fri, 09 Jan 2026 16:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6ED4C304D849
	for <lists+dmaengine@lfdr.de>; Fri,  9 Jan 2026 15:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEAB313545;
	Fri,  9 Jan 2026 15:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jz7rQ+3Q";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BQFy16UP"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CDE1F4615
	for <dmaengine@vger.kernel.org>; Fri,  9 Jan 2026 15:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767972756; cv=none; b=F6DRkQ17zQTiFoQqjjTbjfYFKvXQowJhWGjV/B+eOG0xGFTCWXvJ5J/MXb59CmDMw0pFrKBfhAJe3TOjjYmanmoMQZs6xbPi0xeYJTw0BWIAREpjpIviP+CW0SRrtgXz0GmI4VFsC2BM8HwqApoZcG9hIxWn5t1RE4fPmVguJno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767972756; c=relaxed/simple;
	bh=/kY/nCzz7XipM4D+OHx1C1hWjORLAj+DZAuJ7h1zWvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qfoPHglOrH+WATKm33C37lEyizLo9N4IWnPxQwybYfcwod2fbRxCtgD36Cxj5Z+4iuxChKmV93MTIW3nw2jGE7GvzMQ7RPgsbtv//C7VbAf4fvWOfQg+3pD+4bc7wTZRHJj/GOnXML4Xl8AcuHatxvGz9reOqZxZ4XNYP3pQMjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jz7rQ+3Q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BQFy16UP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 609DtTkw3142583
	for <dmaengine@vger.kernel.org>; Fri, 9 Jan 2026 15:32:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bbDYGHJo1YpAWv7Ekwvpg5SDMRw5uszse6WBwKheUV4=; b=jz7rQ+3QASlEJknd
	DakZQscX/uMlnFcfeTcsBqYsCN/8RET4KtzaUZioLhNb3neMDVjAKtVk+IB5RCJS
	tyOqepatV5h+pXTUL9CQ9uJA50YyOufBWrqcVwq8JR/17tIN/fBQMsD8wS06CgGP
	V8j4ARo4u/uDCAnHRcJfvuilLGPwz6VAkaUEq5gw7wuKRZ97+4lw+aoy94wuZzSo
	RtBbbztLO9aq4W31hi+zV52/5OwhsQ6XsSCcUqBGbCYXp8oGZQp7cFi88jejMgdj
	c/pAV77csMKQV9B7D0+bIb9NnBWeEcxzgIyzbns42PYe9CPMeYihghGt6vtpD/1o
	iaVRnw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bjj8j34ga-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Fri, 09 Jan 2026 15:32:34 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b609c0f6522so7292344a12.3
        for <dmaengine@vger.kernel.org>; Fri, 09 Jan 2026 07:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767972753; x=1768577553; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bbDYGHJo1YpAWv7Ekwvpg5SDMRw5uszse6WBwKheUV4=;
        b=BQFy16UPiDTtHLFN2zQEDkBn9lD1B/U7tiOz3X/38ypfnwrouN7BebluXoF7vxMKrC
         8ama98KMe9lgepbMvVebxeQ8M5GgXqQLbImxhIFw6hGGw7D3rWgihtlPMP27Vw5w8iQl
         aJAlw+19cUYpj3KwwsKyC4rEmcqyn0zsVyf6I5BJm0ZotfMOsOFFKjS8g9H+iu815BiS
         ry0HsYuH/3B7sNWpcD0dN99DZ3iLdKq53ovUuIdaQmW8/cPdrPULFDyLnuJDG+7CfVcc
         AN+iwGG9zgbHCFQdZz8ZBJyt5376qUMRKkcnDfTjf4S38rQOwrZy4VCZzCDnIp374RtS
         5S3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767972753; x=1768577553;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bbDYGHJo1YpAWv7Ekwvpg5SDMRw5uszse6WBwKheUV4=;
        b=i8JKM2SQ+tSfg3AQ3ERdet/DR+AKLL+xgEmHaxe5NcHPTJLwEiD18p0URrG63GDwc7
         v9Ndds56iT8YhWGyWd8MzOel2BJ1WRayjLelnlrTRZ5O7XL5Jc2A24rlvGz2Mz5c0APv
         sfaK/40ZCHe7VtXKDFBDGEyjRLeLmYGM1eY97vhtfYXwLU4ebCTel1C0rAyza60vA96g
         m+AFY+d7vA6AG+ojEeRNG61qx2xXJgjXWh1CjZl/sNtOpiv4HTIcqu/vG4+Qva+xvmL9
         Ezd6JU70VJ78ChEimGBd7fjKsWAaNIMZLb6TIuOV674njJ4DlxkjkC5ngXTy2LQCaYHO
         7erw==
X-Forwarded-Encrypted: i=1; AJvYcCUY030Ew/sNDbkZMJPJt/ScpEQCY2LLVGmAMThI3hCI6Lor4sVCAqrfqWN3mAQjGBI9Cx3Hfmdmc14=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeYUFB7pN67B6JHPDIPPsU3k0VUGVa6UJCboE/X5acVKmxqSe+
	mv+yzhQaAyA95d1+SiDG6Y8YMwzlQLwh8Yw7g/7zR6blJFS7L61vLwuZ4aTXqdjRzIfnXFesLtf
	ZMNt1Z5ddwQ7KoDqXVsty6MEAA5Ud2JAZ0P0/qhZCskgCdSe8Ot/4vdHXdIYtKtU=
X-Gm-Gg: AY/fxX4sQ/QjRhmMggmeqk7ngKfvok4bSN5muWA0f/1BLtDbUXvbSnVN8EpnAHeRcva
	c/1HbeC0glFgGnaR067MpNvG90/bIE1gPtG8dDpt1DZqZzkMQeYZBuazvkKYDmF7ObpJola+cIT
	stTMAaK9AVoerovNC/tq1NUTVnn7gqaZJnjF5H+9zfKAtI4ZpgEvMLH6h4UCxFN3xeQ/kOWwZiY
	2oab7J5zuKh4l8XWOKsn3Nc4D0pMREM6wwLEYzVLtjbT7Np39y3eyR09rl/wyopGU6l8ziOoeCt
	JyW5VA5XB9noOurTGuRaihkMnYHVWf3BX8iPtu/pZG4L8eOlOGZIVARKU4QrYowQmYQnbHUw4OM
	HguWpXQWP/gRyUsIIhVnnOAM2KjCCpmQOkByr/09wIpaad5UXr0ONl0GkDkB1zLprAg8MgTC+1Z
	3zbfUDc8f35DIjD4QVQHbFeteCwEk=
X-Received: by 2002:a05:6a20:7352:b0:366:14ac:e1ea with SMTP id adf61e73a8af0-3898fa09be1mr9503025637.80.1767972753061;
        Fri, 09 Jan 2026 07:32:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFMu/YAZaGy8W3Jf240LoNSAxEKcf6xqLbZeddAYM3aiSJ6VgHPp4V+sxtUdmahoUKDx+cG8A==
X-Received: by 2002:a05:6a20:7352:b0:366:14ac:e1ea with SMTP id adf61e73a8af0-3898fa09be1mr9503001637.80.1767972752476;
        Fri, 09 Jan 2026 07:32:32 -0800 (PST)
Received: from [10.190.201.90] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cc8d29521sm10947460a12.23.2026.01.09.07.32.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jan 2026 07:32:32 -0800 (PST)
Message-ID: <fad41515-4b43-4b64-ad0e-1c656333e6a9@oss.qualcomm.com>
Date: Fri, 9 Jan 2026 21:02:27 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: dma: qcom,gpi: Update max interrupts lines
 to 16
To: Vinod Koul <vkoul@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, sibi.sankar@oss.qualcomm.com
References: <20251231133114.2752822-1-pankaj.patil@oss.qualcomm.com>
 <20260102-fiery-simple-emu-be34ee@quoll>
 <aa62b769-4be2-4e6b-b2ca-52104391a757@oss.qualcomm.com>
 <aWBxbNpRIAxQ6DDu@vaman>
Content-Language: en-US
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
In-Reply-To: <aWBxbNpRIAxQ6DDu@vaman>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDExNiBTYWx0ZWRfXy/m5oHvcS7Nq
 anqwbtK3UspIlG8JBovV56H4bt0kusRnOoZ77tn704txbLzTY7lFSk7n1YfiaNj/f5/pSr5xU9/
 wZ+HpidBykD+eQFFYkJpTM+AKYCUFC0Gz7AnZNhH5WON2gunWBzi0V4bqP+cL7V9MO1eULBaUXs
 Ao36IcgzPDMf16VXV55YxYK8uMzbbb6fr+hbLKWWopj3+xy44zasbAstSmmVPhhDpmHh63YpYtR
 bu5WAzOLUtqmMLX8ROI/gTXvHPSs8N3lgiIlpBuqUZC8r9LS2Aq2ZFTA6yOCu3VHQAPe5zxMbxP
 jWBmR/sqDxznlM47WcjriC+kk6whLSCUAfc3lNYmt5ovHh8QpJP20OM4iuK+js8tpr5GySe1Vcs
 ZVoPR2La47qdmXIVkXMna9CQAjlWhRQHEyDKOcktBOPHlxqzIUewx6AnhbxOdU573m21K4gyWZR
 yefdvDfxMNg/eX19p0A==
X-Authority-Analysis: v=2.4 cv=JIs2csKb c=1 sm=1 tr=0 ts=69611f92 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=t1bloCwPabEWpEwonywA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: 3M336aUiR-bJIgeAZ3cXLVOw7xO1VFDd
X-Proofpoint-ORIG-GUID: 3M336aUiR-bJIgeAZ3cXLVOw7xO1VFDd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_04,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 bulkscore=0 adultscore=0 spamscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601090116

On 1/9/2026 8:39 AM, Vinod Koul wrote:
> On 05-01-26, 12:29, Pankaj Patil wrote:
>> On 1/2/2026 5:57 PM, Krzysztof Kozlowski wrote:
>>> On Wed, Dec 31, 2025 at 07:01:14PM +0530, Pankaj Patil wrote:
>>>> Update interrupt maxItems to 16 from 13 per GPI instance to support
>>>> Glymur, Qualcomm's latest gen SoC
>>> This has to be added with the compatible.
>>>
>>> Best regards,
>>> Krzysztof
>>>
>> @Vinod can take a call on squashing, the glymur bindings
>> have been applied to vkoul/dmaengine next tree.
>> Let me know if I should resend.
>> Lore Link- https://lore.kernel.org/all/176648931260.697163.17256012300799003526.b4-ty@kernel.org/
>> SHA- b729eed5b74eeda36d51d6499f1a06ecc974f31a
> 
> Sorry I cant do that. Please send update based on patch already applied
> 

This patch is based on the commit pulled in linux-next
Clean applies to the present tip

