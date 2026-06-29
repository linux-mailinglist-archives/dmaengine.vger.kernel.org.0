Return-Path: <dmaengine+bounces-11856-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id g+NcI4VGQmoz3gkAu9opvQ
	(envelope-from <dmaengine+bounces-11856-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 12:18:45 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DA76D8CEA
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 12:18:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=mOEekcEz;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=bKkH+vLl;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11856-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11856-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D46DA303D2C7
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 10:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7134D3D9DB9;
	Mon, 29 Jun 2026 10:15:03 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD483DCD83
	for <dmaengine@vger.kernel.org>; Mon, 29 Jun 2026 10:15:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782728103; cv=none; b=ZXhWnmetJ7IpjEG/JGiu2z3S9GG/q3c09UZQEA3br5gbS3gBtkkgFg3xIiKD162eovXm4iH+i4oiqjfOd7Lc9HqinixJaVTIY5F7fk48wzcd1FZbCCun5lkdSdLZrSK96b4zt6Rp1R9psXg2LfQCHK6khOYtI/1E36u19rLFXRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782728103; c=relaxed/simple;
	bh=+WAdYRRalhghIfuIm9qMuNk0e17uLYcSMnoP6DcjLaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G+wZLsfvIID2jOLMzDuCh+OILn/0jTvnAGTgu6a/a45dkj6llWSWcg3LFBV7FcZQjixfTKe7wbqxxuZL98VdsMbylbc240elC4Yh7YL5+WqUOIxmQXrc8chFdgtUrNJSqnn0hmDwh0YLXLDrnhIREB6XnXZvUMYpjj1a4MAMVHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mOEekcEz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bKkH+vLl; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T9nEe32529536
	for <dmaengine@vger.kernel.org>; Mon, 29 Jun 2026 10:15:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rNWml8xksVkoWSoINvr+qZ3ly2K2jA76uLu65SSIdxw=; b=mOEekcEzUqWlQA+L
	D0F2cqAQud8ZOR6M0HLij/EeLasKzaF50xxU6mFvODMGMwIyLv16Iik1g2UHw3Mp
	8sn/Q/O1uiD8LxOV9rkQDg6ExsPgC/qfAMfhlgvSb4UUoN5/arcIIvZgt6OagUbN
	DYTA0nbudLZzzPPC3Iq7PdcEHWOgRIxN/hJFcFhZ+1nz7x3F4vdx43UmRRe/qwNB
	FU6iV4bfOz6UwCpGk51Lx+dvBNHwlffaoTtVBuorrCXKwM2cPmROad2FeyYc6qGh
	dkXNtwG+TlcbeZRBTz1ZlXp3tuctomLq7LOUubYnWHV4iaZFaMuENAQe3mEvFlMJ
	I6bDOQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3pdkr373-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 29 Jun 2026 10:15:01 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51bea07880dso3940441cf.0
        for <dmaengine@vger.kernel.org>; Mon, 29 Jun 2026 03:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782728100; x=1783332900; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rNWml8xksVkoWSoINvr+qZ3ly2K2jA76uLu65SSIdxw=;
        b=bKkH+vLlWlWVgCeFi7lRdzHYSRHEuODX8A/3GxCW158Ne41AM0ize0s2RO4akDmEm0
         H6epKDI5CTd3yOgz/r5tqywgnGSIrSyQKfauYv33fYR6oKcHGUL23euXrI14zPNG4WKB
         V/abXq0uo1heajna0BuWNlSZP16EXit/MuWPIWaEXmm4mCV4+pbSP8rJu9PANFfq3d8Q
         NA6uEBVuG6TxeqlCpioLDnW4ostH20x1uvb7DiyWgOb8kn3LPod1bQE3aVDBizu5nOST
         ozvC2WOMu1s/84LmIvJseF8+BALzYy4wrO744/FTCKhdyuxUW36fn1A3/qGxmTkzhJMz
         iJWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782728100; x=1783332900;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rNWml8xksVkoWSoINvr+qZ3ly2K2jA76uLu65SSIdxw=;
        b=Ara1Lo9txjWkgBvXcvPPjy97vHfbW6XtW64T6XTDwMarZdBIVCAQ+iI5K0uX6D8OxS
         b+F9DI+0vkwF/ScsdVITvzbLUT5+j0xVn6+WrPeSMZRGppnK7iWIHW+Xh2RDEa4iZQVV
         FoKf0UcHvP3JY7oNzd0RXGMaOCE5uQagEkQztE8gTOHutTdjUBH9+L6l7Tp07+Yb3Nzn
         7ldnjxZlZZghNJF4EjmiAWokxAS+QFLuJJ9jktA/PUsHZb8WYfaidJYHJ35NmBQp1zW2
         83TWuPp/O6okGIU1tNfwOVZqESMJNVBo6HmjWNX4fXVE+fWYL18vdUTjqBgIS75jKZGS
         dM6w==
X-Forwarded-Encrypted: i=1; AFNElJ/w7Q8+vRe5DhARFV36nCI/S7xGJFz+8bPEoZOVnrtJK1dhYdiFBIMn5vB5GmtvpE4/j4JhGQ9j/oM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzM0DvUGAWBmrFpnm4TGk8jiIUf+dSnPhesNHYOOCVunKuCxVcH
	i521mgVlTJOqx6uTvCEhcK7fJ0tAKCCEJBUCyhgpydiuc9OwutAd57tnEzQWClttmtA2hRUl7xa
	Di472ATX55WsoWQYXD2da3nMaLnt1vFWISMgUI1pkGzkGc+IUYeoL1K8uqLrSExY+bfdLAb4=
X-Gm-Gg: AfdE7cmvfl9uMcIAwQHG3OgSMLSd8z7E76EIVIfhYfOwOj/K0mP7o0j52mYt+/4h2Vp
	c3xnFY4Ev/hcb7Wj6eJwkg0T+qw1LBa6sHgDw6FmRVl+oUf6mEA13i24B1DtDNChiZnpFmupOrM
	QLJtrZ1Lw8fVxzgPcynnHeyOGUP5G5VLzrEhLpvyFmLJFuQRudB6EF5YaoxO48eB7rZ3ohEQslg
	hnqpZkrYXhcqa2+c/zqIZq+jWhQNtOaZvVfmGtJ0sDTE7v69RDTIOgfO6IKCB8o9TJa589PStqu
	n8Bz8M3BfutSFe6i1s51Rquo/SjNsgIuJNNnIH34VEh/1pk3xQXpMW2tVYCjJgm+jDzGJtWYjI8
	izfKQ8iJYCfQYkIc0ahHE6vhpOt37Tb5ZN0E=
X-Received: by 2002:ac8:7f13:0:b0:51a:8c9b:64a5 with SMTP id d75a77b69052e-51a8c9b9539mr89108731cf.9.1782728100474;
        Mon, 29 Jun 2026 03:15:00 -0700 (PDT)
X-Received: by 2002:ac8:7f13:0:b0:51a:8c9b:64a5 with SMTP id d75a77b69052e-51a8c9b9539mr89108501cf.9.1782728099986;
        Mon, 29 Jun 2026 03:14:59 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c126ff294b6sm87171166b.21.2026.06.29.03.14.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 03:14:58 -0700 (PDT)
Message-ID: <690a3d04-f213-4985-b020-eb348c84e5ae@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 12:14:57 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: qcom: gpi: correct channel name in error path
To: Brian Masney <bmasney@redhat.com>, Vinod Koul <vkoul@kernel.org>,
        Frank Li <Frank.Li@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260625-qcom-gpi-err-fix-v1-1-5ca3f00fe2e3@redhat.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260625-qcom-gpi-err-fix-v1-1-5ca3f00fe2e3@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=R8Uz39RX c=1 sm=1 tr=0 ts=6a4245a5 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=E0WXl1KephRpjzEqspwA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: HuIxP9gtjMidT_LMq5h99uZzLhR83P9L
X-Proofpoint-ORIG-GUID: HuIxP9gtjMidT_LMq5h99uZzLhR83P9L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA4MiBTYWx0ZWRfX+1KyJF93QyUy
 JKgbQPzW8fomdbo4PlYATkfdabTnIorNzIQdUiIH0Rc4PbjI47SRlFsiHqr9RhjelxdWhjaWaXz
 /RiTNQ5mmc6nfST/y+1xw9afMc10IUrd6aGteOI4R+5WBjzBLTa6q3j1SFl6EPKoq6/Zdwl9qzB
 UvNXt1zql0qKCgrT67Z6sHzovhAgjhSHGTcz3fuFKt4qxbteW+mUGnju4Mt6+HDZPJAWbhrvfVU
 kiMmPhh9WtpNCFQVcBuPNrCaUJpb+ZtbgSjHHQqX0vfjjIyC/mbTcjJTD8bTKY5B7KIA2atOmWj
 6yYZRrsNf014SzpNM/EZOaI6c4XuNbn4mrxQYfB61KX81YFa3zwHHZ84Gpfa9G/J04hF5ff/oYf
 iw14bNXj7vBQa68F7wRC4KkCGrzSZpMfS6DWJKLEb6F4raptov2p/GJWBUdlk1COisaq7mZobwk
 nV0AJ4re8XhKlgjZ6Lw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA4MiBTYWx0ZWRfX19wg+JJO0kIJ
 6xPZboR/7E52iERBfFyeKrN/KCOjhyLoTfpMGerAW6MTnTeOBOeEM1P/0ZZAYG4GJhn6/H7Jdqw
 wEbGFx4eDDOSqIuMCLygYXf3Op6QYko=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290082
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11856-lists,dmaengine=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:bmasney@redhat.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:linux-arm-msm@vger.kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[konrad.dybcio@oss.qualcomm.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email,vger.kernel.org:from_smtp];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D5DA76D8CEA

On 6/25/26 4:21 PM, Brian Masney wrote:
> When attempting to start the Fedora graphical installer from a USB
> thumbdrive on the Lenovo Thinkpad x13s laptop, the following errors are
> shown in dmesg multiple times:
> 
>     kernel: gpi 800000.dma-controller: cmd: CH START completion timeout:0
>     kernel: gpi 800000.dma-controller: Error with cmd:CH START ret:-5
>     kernel: gpi 800000.dma-controller: Error start chan:-5
> 
> Looking through the error path, gpi_send_cmd() sends the wrong gchan to
> gpi_send_cmd() in gpi_ch_init()'s error path. Let's fix this by passing
> the correct gchan.
> 
> Fixes: 5d0c3533a19f ("dmaengine: qcom: Add GPI dma driver")
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> Assisted-by: Claude:claude-opus-4-6
> ---

The "channel _name_" part of the subject bugs me a little, but anyway

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

