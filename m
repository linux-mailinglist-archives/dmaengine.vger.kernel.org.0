Return-Path: <dmaengine+bounces-10434-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qL6SLt7KBGp2OwIAu9opvQ
	(envelope-from <dmaengine+bounces-10434-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 21:02:54 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F465397FF
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 21:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 921B131059D9
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 18:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CAF13ACA43;
	Wed, 13 May 2026 18:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ipli4z7r";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cnbi6zYS"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416D63A2E07
	for <dmaengine@vger.kernel.org>; Wed, 13 May 2026 18:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778698539; cv=none; b=Re5MB7rLrpG2wDBRyZwzYBtybuAuF9eapQ9Mh/wDtBwnMWIoNWHkYBnfPWvHoPF5VATuX7o+woX7UtH5kGChKZ++tKutQyq/0uiJR1pNRWRvzt3VRNS3olxmF8+eT7H+Sh1CtcCPx0jPoFUGk7holOEZQtBGishqu6MphAS0yE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778698539; c=relaxed/simple;
	bh=7d1MCfAVLf3Qy1Ocyr+tLbR08cmldGisnRLHy+zPlU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j/pjiwUtTaAUPaaP+Mf4f7LBmzoQgCYm+DXYRWvoAHiUvHRudh7j5EnGyPp+bMWlrVSLcD7HjqPnRKCGv6ptqE08RTbgKPKTRGh/TWLcodsYVcXkc0rsjPSeHSZBxiIk3pkFBunrgsgno+WtpW6u0vWYjC80M7qQU8me7Yzf8bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ipli4z7r; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cnbi6zYS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64DGA9rW3007122
	for <dmaengine@vger.kernel.org>; Wed, 13 May 2026 18:55:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LzeRmqZFTja2xkxb3awaacB0WgZ4dRBKwAgkhMjHsPE=; b=Ipli4z7r9MYmSUKv
	Uxuw7+hnFKKWSrdcYrffyUEdeZLsqZlLB7URTNxUI6WVvEg+pCoJsKg9vsFsLGtq
	1ymy6NlJ0pgME+JDUNEhMl9zbLid+lZ/6p0E/cFX4qLsWek7RAEQIV9RyFuJ6QiU
	c5ILbA0+JzwepAdqAySkAXV/zKzLxRUsztgseuBjcGbset0WKxtn29XWtVmBPG/h
	5R3HxbDG8uH9jI/w1715Q/bkJT75QbTI3UUWHx3Ml9jm9NOVzHstDSYGCy6BW2Xp
	LkJgPjLHNcBcU7RlB/px8nEK+N5iMX26H5YS/8RQ22yntkINW4WjK8LMCvkSVB/Z
	g77zqQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4py0j64b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Wed, 13 May 2026 18:55:37 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ba838d3fa4so78791135ad.3
        for <dmaengine@vger.kernel.org>; Wed, 13 May 2026 11:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778698536; x=1779303336; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LzeRmqZFTja2xkxb3awaacB0WgZ4dRBKwAgkhMjHsPE=;
        b=cnbi6zYSANDtHdsAgp7eej0Hlt1vrSK5pPOwMC0ATKnxQdpROh0v8AetTesen0MEaz
         DPQ7SmOPJ8/keYaC0PnUMOZ9vszUnlsC6fr4/nvEerkMgeQnvc1j26CDh/O3K4Ty7Qat
         4WbGZNQ4KsWY4golXquudfB6+Eaotun7uObQK2zsnGbkocqe+PoCSmB9X9oDmON5HAzK
         fJcF9Aa0K+5bjLUbxF3QuXE2wHg0SnJO8Zhvl5/mNbFXkMciV6jr53msCTyUOxxr5OiL
         DoUFwotmaRFDERApZFI5WlewgCx3AIedbI2j85kY2JHk6cux5OId6mCtys/EkrrswsZD
         ztaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778698536; x=1779303336;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LzeRmqZFTja2xkxb3awaacB0WgZ4dRBKwAgkhMjHsPE=;
        b=GSUF3TOli4VoUq70algDtTeMUNCY0ct3RQvSUAkScv8PhCxPu1l8pIBTUilAB/w8pN
         0rDaOtwhAzv9k4p6luaPc8X179xRbaT6Y8gMjb+aIjwP5iTjPhPFaWdH2ajsp/EZ07G3
         oqXAr0vE5Osn0wd55jzm2pnntb2FXcpIPiuwCsEC1uJzuU9owJLK7R6jObhJtD/NLsMj
         e0Rg5afB1BIuIbWnNB0XSHDosbxfkDfPqyiYic7KsAU9XV4+1/iHTXWegySj0D2s1CL9
         6mMHPqYGjxJ59ZC63xVJ235+ZYx2CsKw/2ZdTusr1gAA6KBTTpD1OG2huJhl8/Ge0FmL
         tq/g==
X-Forwarded-Encrypted: i=1; AFNElJ8fBt80jinz/qCXOc3WlxI0vmh3RWhuOltrNZpOk9N0hKMXCENllOIsMkewipewL4LaiZZkrkFd5K8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLSE5CXMvRmW7qRP2BJVldYnNtzVzaTVRMnpCUTQbtcsLNLY8j
	HriuIOonAJPVZL18UpXhxPkHN/TZrLrhMiEPTeCHRmKe3GbZYOwtQQQfASK3kQaU4rv7MBLz9XF
	hPEabUDEUcBtMbc31a41Ui+MdgRLh4RJqGjoU3LLyh5TezxkbNbuKa3dQcwGAf4I=
X-Gm-Gg: Acq92OE/sjIY1Pve/7BO5jKuqUQ71sSIV8PvFiY1s94oDxeZb/+u/PCf49xuYrpclY7
	yFvP9soUP/Deehp9pIfR+5Twy8hvhaquses1AMEVQXpk1yLYV8udnZ1/xHIACub2yqssBfYsZXr
	En5Kt2y9kimoG+HgIZvPhNLXdh5xspQwumbwRcdKLMZSATbi3ZMtcA/Hqs0KEKRk0BM8/7ls1rh
	k/5iQa7OUGUQNsWafjaUPQIZdwrEY/wkhFGtxFaFpwJcfjtMd6q5w1K19ZWoLUHfObnakTianaf
	7Ol46rPr9SsJkIjRJa0WD6l3yutzlFn10UcvMbaRdFQUvR4CO1uXVj+k3WPxO1E32/ys/Es5QlV
	5sV2rFoed4yDE1WBfOuxykGyahlH/S7H9Ld0UcVjCKBp2cBwSLTIllc9U4wuE9wYt
X-Received: by 2002:a17:902:d486:b0:2b0:b290:f2f4 with SMTP id d9443c01a7336-2bd3020f39cmr43465805ad.32.1778698535781;
        Wed, 13 May 2026 11:55:35 -0700 (PDT)
X-Received: by 2002:a17:902:d486:b0:2b0:b290:f2f4 with SMTP id d9443c01a7336-2bd3020f39cmr43465465ad.32.1778698535323;
        Wed, 13 May 2026 11:55:35 -0700 (PDT)
Received: from [192.168.1.6] ([122.174.188.197])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e99be6sm167582685ad.68.2026.05.13.11.55.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2026 11:55:34 -0700 (PDT)
Message-ID: <227972f6-7de9-4b70-ae51-c27ab5532c01@oss.qualcomm.com>
Date: Thu, 14 May 2026 00:25:27 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Add support for qcrypto in kaanapali
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Harshal Dev <harshal.dev@oss.qualcomm.com>,
        Arun Neelakantam <aneelaka@qti.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20260514-knp_qce-v1-0-0ebdac98e50c@oss.qualcomm.com>
Content-Language: en-US
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
In-Reply-To: <20260514-knp_qce-v1-0-0ebdac98e50c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE4NiBTYWx0ZWRfX/OIgvfQQGJdC
 Y09FvIhCeK/LZEPfCl8B3MNl491S9ZTtnney9mRkpqEwgXASOU4h/bkMkMOtS8vXvvfzy2LJpYc
 8UbKN36wGMcSszOjHHYg3kRHE6Gy1s5p2kHFKcVgjBXeTupmuP99Dg41JQja8oL8b+ajXyIimN2
 vSV8WoUd4GoCJhyQbnlogrNKqs6lli/2ohDM3Yqo7TX2gKjSRQXwU5jJGxKmxkxc27kQp2fP/Em
 hCUytnlt/81lBmV4DocirSYvB0tZ4GswyC0nml01LVPg+7gLQTIOsXK74t1XtvUdmh13ZBvq10I
 n3BfZTQMbKfKAn08ElQNi2dL7tw4aCcgO6ZeT59/VswvdpTEWtwOYr+TAU3RW1YYW+Ww8HT/QO2
 Innt3t0+mnSiYOQJ0PQuT5rOoIsNtq9DXPAQbJaO0f1f6rwDz/GT3MW/SxmAzF0Z7TRV/98AQc6
 /Gl1jG5ckrS7i4PasGA==
X-Authority-Analysis: v=2.4 cv=XqXK/1F9 c=1 sm=1 tr=0 ts=6a04c929 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=j3xDveksUu0zlk4lKs6shQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Ha7b9SRUxfVPAdQjIlEA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: n5zNrrBAuKlZB6JIU7VBESZW7OcrqBCS
X-Proofpoint-GUID: n5zNrrBAuKlZB6JIU7VBESZW7OcrqBCS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130186
X-Rspamd-Queue-Id: 44F465397FF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-10434-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuldeep.singh@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 14-05-2026 00:10, Kuldeep Singh wrote:
> Add qcrypto and cryptobam DT nodes for enabling qcrypto on kaanapali.
> Validations:
> - make ARCH=arm64 DT_CHECKER_FLAGS=-m DT_SCHEMA_FILES=Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml dt_binding_check
> - make ARCH=arm64 qcom/kaanapali-mtp.dtb CHECK_DTBS=1 DT_SCHEMA_FILES=Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
> - cryptobam and crypto driver probe
> - kcapi test
> 
> Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>

Sorry for inconvenience.
There should be v2 series instead of v1.

v2 series is now sent here.
https://lore.kernel.org/linux-arm-msm/20260514-knp_qce-v2-0-890e3372eef8@oss.qualcomm.com/

Kindly ignore this series.

-- 
Regards
Kuldeep


