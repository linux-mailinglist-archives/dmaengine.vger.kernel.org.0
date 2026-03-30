Return-Path: <dmaengine+bounces-9707-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBrJNSwKymmL4gUAu9opvQ
	(envelope-from <dmaengine+bounces-9707-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 07:29:16 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC4E355893
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 07:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 92AD8300B990
	for <lists+dmaengine@lfdr.de>; Mon, 30 Mar 2026 05:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32414390C8C;
	Mon, 30 Mar 2026 05:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g5lCeoyS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eGb4l+bq"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51F833CE92
	for <dmaengine@vger.kernel.org>; Mon, 30 Mar 2026 05:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774848540; cv=none; b=DGMKY6Q7wJIltT4GgYcg82cJ3uYO1cyeMjnwpHBSevevLjkoeZLheGBgX6spnd/l5tlm/qGVAEyTKVxOZvKB2cIOg4bUep97i87XlbsiDo+4pO6KX9ZUTV84irkyFptYEbGQXyPfj0rZzbzY32fwtISunlMUzpoykaZYnj7I+uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774848540; c=relaxed/simple;
	bh=Oqnfe1B7pgXZGMnxOjT9IdortdmUJNYX97ief7kKKuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RlJaaeOusbE8PclvTvs4OhSxQFxWT+3n1WB4gGsSr+ifF6c3O0H2a8R1jyTjCTqFsbqPimabZx2fVnHqxsyS2Fvt5lQhKUtEQ/6NoQWdnqSUxrRkLI4gL66uxbo/zLAI7UWFq8oZHBGBEQVrSeKYWkUwhHwz5SGzqUx0DMgocAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g5lCeoyS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eGb4l+bq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62TMr9NA1375183
	for <dmaengine@vger.kernel.org>; Mon, 30 Mar 2026 05:28:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	20GNW5it+X2su5CUYneKv8hJ0SfE9B5LXD06+2GpUP4=; b=g5lCeoySpJ6p+RGZ
	xk5oP67iwVMc1hZO7Zph4sopamh8o7qo1u0ZHjXuRWpQVOcxa63+QEavAACHGdlt
	TbYQqLRmK23SAtatcXsAjoX03lT0H338vBOnzvt54beJK4OyH6ZHPNBYizKdHa8s
	QJ3PkYO7pQf3qPip/ZfTTGSP864jYNeAjMDha+s/uyaTJYAYz4UlQfRoCkcN3PvK
	Zz1EVi7IwrRGOQw+dI4DEMElxbrc7zeT/XeBpq4RZ5QE2AVizqtYdjT4SUn2gLSU
	PaYNuvCEwg0bXAOiCM9+2/ZdDXUN54ouW+auflLfMi8Tif+oG/ITyMi6LUtpbbho
	TZuShg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d67714h96-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 30 Mar 2026 05:28:58 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-82c69a72aeaso2562040b3a.2
        for <dmaengine@vger.kernel.org>; Sun, 29 Mar 2026 22:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774848538; x=1775453338; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=20GNW5it+X2su5CUYneKv8hJ0SfE9B5LXD06+2GpUP4=;
        b=eGb4l+bqm6PTQ1fYzUao7o9q7o/2yiaKx9iNU0iT3QQbeNL4QqIuQZPRcz9Sr6RLtJ
         1Rrc7Gn0UykV+cIlumuaxbBItiQnzl1hqhM8g9atU732cTw6SYRZvtnxHSzjqxrXp/A6
         MTB6m5mm9ZX9cBgTTREOQ/fciqQ82GgNns65zLHcQ+mHZjeGZaEpx3hT/jiMYuYPZygW
         fdrOAAhQ4taIFZEHY2hdDuH9oUT6XXvYpPzVjh8n1ZrkA2e9JVBl1lpK7eQtZi1EmBL4
         oyy7Ho1Upn3ZK6/xD5cZQd/v56ivlLkHsWRyy8XC8rlipE4OLfoDExobt5s4aZIAPoro
         GETQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774848538; x=1775453338;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=20GNW5it+X2su5CUYneKv8hJ0SfE9B5LXD06+2GpUP4=;
        b=UpkWw44mX4MLk6DJ6IwXVBfuH0C/azGJcN8T3Psio82t3KywkPSjSEe5iSRCxy3NKn
         MnieBQDLVknhUDYad6AQWK/cIcecCT0R3tPhTmWFCjgbKjfcSmvpBp4IoOuAwhpr/Isr
         bq4kRUudQ58EdnO6ZcvaO4aCgWS9ZRm/cM26DwQO9qNlpmTDKhKv6vAJCa8Ah38WFRlX
         q8XavYWdbPWRBq/t1yctcdJXypsp27NlxnSk6Y5WvGvaxd1i6KjzFo94TiTN2PmnROnA
         yaxYP5ivQNBp+yD6HVaaPm+fZvn+S3mo9AalKUptPwbjPg0y7uPbE4/CjIRQPq7yw9Ti
         sRZg==
X-Forwarded-Encrypted: i=1; AJvYcCUJYq5PRJtEmLsNo4kUYsom5R+LVNsyn26dPjx/6qTS3dIpm0eEgeQlyCnKm030uJhBhyBH/9QYam8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXVXvzStAZ2Fw0TIjcqrSyl/VcPHuHrbRBgGVhnWbXxUgWOD2Z
	ZJ6OuCHLjnbSNaXrkJuIRwYhU7CpyJ4bfcKPNpdi4zt0LR3hkxqk1nW6zEb3nHHuWvIfA14nghP
	LB31I2REuo8r10UGhIR1V7qebKVdrjUKRZtspfTDBdb7oKdJF9AhQYPlcVOQA0B4=
X-Gm-Gg: ATEYQzzRzJZgaaL7VPFnDI8HKC3bEj7pGL6CUpjD2DoeSu8jIyZWAljSgjMXa/ttSqi
	GqzWcqv9dhjPAsKmlkLU6teyl7A+Sd2pSAiFa2qX+tl5eMlMbJguTLJ6KDfjXV250AUvesy6Qz4
	KFzbW2jBM7iF87Q3fFcOqFPkR9xfEoLZ1l5Qr3AePLzqX2vcHGNOpeuBkDy8SqBlMXMGlVL8Vmx
	eYJwvQNAuZZKFrRMsogi468kTBkiW+3oq2NV4bzzFsoUiVAK1stLG9NvlEKw6Zd4WHOveD43Y7R
	xf8TYqpbJHz8DKVq/yVnOKLqQO4QmAUcEgbR2h8ZgMhboBOuSrPOPe8VAf45n4cHEX7RsGz6UXa
	O56PEqu0D4/NL+YSawGQPpJVqKyDvANiuHq3z/7H7tZfWyQpmXlw=
X-Received: by 2002:a05:6a00:438a:b0:801:eee2:45b6 with SMTP id d2e1a72fcca58-82c95e7c457mr9909598b3a.24.1774848537569;
        Sun, 29 Mar 2026 22:28:57 -0700 (PDT)
X-Received: by 2002:a05:6a00:438a:b0:801:eee2:45b6 with SMTP id d2e1a72fcca58-82c95e7c457mr9909565b3a.24.1774848536921;
        Sun, 29 Mar 2026 22:28:56 -0700 (PDT)
Received: from [10.217.219.124] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca8465785sm7263307b3a.18.2026.03.29.22.28.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Mar 2026 22:28:56 -0700 (PDT)
Message-ID: <d98d21a9-b355-45a8-a8c0-a0659792e76b@oss.qualcomm.com>
Date: Mon, 30 Mar 2026 10:58:50 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dmaengine: Add multi-buffer support in single DMA
 transfer
To: Vinod Koul <vkoul@kernel.org>
Cc: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Veerabhadrarao Badiganti <veerabhadrarao.badiganti@oss.qualcomm.com>,
        Subramanian Ananthanarayanan
 <subramanian.ananthanarayanan@oss.qualcomm.com>,
        Akhil Vinod <akhil.vinod@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-pci@vger.kernel.org, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org
References: <20260313-dma_multi_sg-v1-0-8fabb0d1a759@oss.qualcomm.com>
 <20260313-dma_multi_sg-v1-1-8fabb0d1a759@oss.qualcomm.com>
 <abkyyBxSnwZWAt4-@vaman>
Content-Language: en-US
From: Sumit Kumar <sumit.kumar@oss.qualcomm.com>
In-Reply-To: <abkyyBxSnwZWAt4-@vaman>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: CVkT6pCn8jaVaeggCJRZdMVXEf0DpVd8
X-Authority-Analysis: v=2.4 cv=efYwvrEH c=1 sm=1 tr=0 ts=69ca0a1a cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=kGe3cHaNJUDbgVJfyvsA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: CVkT6pCn8jaVaeggCJRZdMVXEf0DpVd8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDAzOSBTYWx0ZWRfX40KvinFVLnDI
 ETX6dnQb0dsJM8QP1AghooH+P1Alb546UNieheQSynEGiaeYR4SsiSXqUxe/OGkS8GKXkQdpPtD
 7dxJTDz6MviKcP45JNnD4DzrIKygDEaTm4nM+lspYznGMSSV4OsDWFfofiEb5MIac+gK2z8XBrQ
 Bq5a3fLgxuSckk9Q/fqBtTQHp8AfOIvc3F/pQ2ZQL+BvYrRUhkYZL8AU0p0Zm2aAA5co43V4SQq
 mRt8L5rKo5VVMlcnJ70Zulirr32W1OopCvzK9eZU90Lv8u3rkF5xz6EQdKH5fJi8ff1Jb8esYAN
 8LvbG/Pmki0hMcQ+MutVOIdLDpm219JaoutFHEd/e8wHPiPjFaynUtVRQO9AScFcU3zXU1GQTS1
 q+pgKNE38in6KvSt4qqX3aLeRELVUjRep3VZ/6LMcUydIkJPTEchJsBAV/yBrkvW2BqxWrKULaN
 nDiL4cQrgDuMHapu0lQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 adultscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603300039
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9707-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumit.kumar@oss.qualcomm.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9BC4E355893
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/17/2026 4:24 PM, Vinod Koul wrote:
> On 13-03-26, 12:19, Sumit Kumar wrote:
>> Add dmaengine_prep_batch_sg API for batching multiple independent buffers
>> in a single DMA transaction. Each scatter-gather entry specifies both
>> source and destination addresses. This allows multiple non-contiguous
> Looks like you want to bring back dmaengine_prep_dma_sg() see commit c678fa66341c
I was not aware about this commit, I will bring back this change (only 
the core dma part).
Along with my changes was are integrated with the above commit.
>> memory regions to be transferred in a single DMA transaction instead of
>> separate operations, significantly reducing submission overhead and
>> interrupt overhead.
>>
>> Extends struct scatterlist with optional dma_dst_address field
>> and implements support in dw-edma driver.
> If this is memcpy why are you talking about dma_dst_address which is a
> slave field?
As we are going back with the commit c678fa66341c we can ignore the 
current patch.

- Sumit

