Return-Path: <dmaengine+bounces-11638-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PxQ3OUABNWqllwYAu9opvQ
	(envelope-from <dmaengine+bounces-11638-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jun 2026 10:43:44 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 806E66A4ACF
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jun 2026 10:43:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=g60Te3VQ;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=Q6HoYynS;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11638-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-11638-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C9083301588B
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jun 2026 08:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08B22C325C;
	Fri, 19 Jun 2026 08:43:39 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE2D31E842
	for <dmaengine@vger.kernel.org>; Fri, 19 Jun 2026 08:43:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781858619; cv=none; b=o4mIrdRIi6oi9EoGAOApdr0ua7mxSvStptRnSCXSWjQhnGLSecbCvKGFJbWxhflenHHx/XEhO8Uc2rSxzzUpi9+cTvWLEXiMJYDdoN5sX28+T8B65CuZ7o2L0VyYny9ORfdR/cgYum9yZdlo6r7a7WQXoTs8QqvwDaNTSQbhL+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781858619; c=relaxed/simple;
	bh=bc31Yr5ghRJg0f90YIfKarYrpbtyGTI2c0LzMXhtT/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=llPpz9XFVoV7Tekgyq8Sp++6b7BesOYH0QCPsyfmFPKgUJGLZjJoHIswwQjshS+BlVgaSz5hOe1ew8w3nfGUa2hTzSjFA6hnKOqP+6R9U68hHCx4RF+0MSqE+kDSHmCWgkFhMDhh3cFB09k/deK2WVLb1iwhHT9W7239pqA3g10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g60Te3VQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Q6HoYynS; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65J7QwJ4081498
	for <dmaengine@vger.kernel.org>; Fri, 19 Jun 2026 08:43:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Km4wby96Y6EXgbIfd/nWraW8VyrR6b3sietG3sRGZdw=; b=g60Te3VQVRD+d3SI
	eAg2m9qf8KMNl4XoscJ2nFhZ65TWJYcplYvixYInSKPiw7PMQV1pOiURi7/V9f0T
	beu6n7qHbl8oFqYO5PxG5WCHQpVbm+NctmRK1Weg0OUDGso5XJ8IeV+oefYi+X/4
	3GgYp1FlMzFr07r97Dh0Dlcf7vaVZavuPa98/FJ3U05JjFCri2Yt+KGOxniVo+Hb
	j1ifMUlmhob6KW/BzjxserpzFLUeOLEpKK393VOzDACYzva6wHosPtpitLz60Gep
	LrHPxyJIvAmtZ2/95j05LXJAbt1mcN0lXDx9l7UYvsAzExEBSUCYAhVMAxN2xAls
	ktzwxw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evmtjax5q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Fri, 19 Jun 2026 08:43:37 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2c0d0516ad7so19266515ad.0
        for <dmaengine@vger.kernel.org>; Fri, 19 Jun 2026 01:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781858616; x=1782463416; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Km4wby96Y6EXgbIfd/nWraW8VyrR6b3sietG3sRGZdw=;
        b=Q6HoYynSfFYAuuxdwGNdohuoMvFE73cLjrimW9I+CJ0elGmwjG2+9n3HXmIZaTs7Zj
         cEU+pUWBru6XDQn4MtnzH9uWUmFr/DcRBSEGWsvc3XVryA7MGpnwuO4NvwqwszyBrMau
         X3boyZFBISLP+Q2frplavbaweruRg1PeChQKI/bEGRbHT1pqoPhopkRNmMNcbACsiH9A
         rf+VWU1PK83pvyeD6ZaXEwMXfqldadsfY4JvAKlKqOzhaoihuN99GWtrDOrfHkHGaBdS
         zppVOigpPDG7Ea2TkzojT8ExGG4qSGSX3CL46HT7e1kf2c6+0sdNGlsds8JiIKwAzCEw
         sh3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781858616; x=1782463416;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Km4wby96Y6EXgbIfd/nWraW8VyrR6b3sietG3sRGZdw=;
        b=PKM8YvNjAk3igKJO9cojJJO55TLjwMOj8murk1/1GoRDmA6UcJgcRTRo5PDDNP4jtD
         d3BHWEX+VBFepwpwdW6eaF/T3HEKo5f3NbjmQjxJm1MswlhVIzD2wBk8qBFoTNAeYYdH
         byQJumXoMbjOdu9GwDfThs4wBa3OCwRd4RckBrbE10PIroQHXw7GShsHfEg6bQeMhjsT
         LiJplqtIwc2NYc1mbHoPG6DipYdNMsWWIF1YbZiLGVWI3l8SyGUhwX14i1y2UluSzT6o
         evHpkHVIoDGN9xrhoatlOp9Ii6jCgNN+rTCwdXtTIcLninsmOEakvGqmQVph4ul90ors
         zcmA==
X-Forwarded-Encrypted: i=1; AFNElJ+NDUo/DPBQgDcm6+ThUw4bNkEWbTm7MTqFbfiMqbM5AJHqVmBfT0ZSDD2v57MKIFRyoWQQTVqmKBg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3XofgNJePQVXT0+/iOeSADtHmNTEGG89lZzu3ZLdb4MyRYY8z
	5brWSlnpVMmCOy+74NutmhdEg/gIYd5wApWz1m59iIDo0mD9gAMiJ4n5Zfu3135fY7nalGjRL/q
	n/b5cfmYrDN76kxuT/1IIDI0InEtbnO+A9thFCpuv2H8IyC+yfUeuT+beoWFGA68=
X-Gm-Gg: AfdE7ckkjLwzuksQlmtM5o4z1vRDYYiX7ZuZjxVfyx3nVDlq1r8oVHsKlSgoeBXnaOp
	VXTAZK575/gz+7VBMX+3xfOWvED80UQ+XGYFmeZjgHpEmeVqs7G+i4MuagGVCLzdSBkG/FHS4Ni
	TOx+JYRwMXm1of74MfVWkRBhH9qxTLbFEHVuML6SqFU/qHHS4+AWTL8PCCG5OELsEk/bneNmCoC
	0+8LQ8qZFCaKWx+CRgdzvcpXMDV4nmO+3t9/D73PJ/qdF2MOxSBSb4vob1wCNBa6a/wcIpo5bUc
	wCxwWqjf2OCbBQ+GLCi+ospNKaj18grwbqMeN3iaqad1wUmdr328cUI/D8pluOZr6BgbLzXhS+R
	zJchq0gub0wGiPJUh9ZuZFrJ5QzZrKoTHB4xFiAzm6OU=
X-Received: by 2002:a17:902:e947:b0:2c0:e7bb:9081 with SMTP id d9443c01a7336-2c71904bfdfmr30535625ad.33.1781858616320;
        Fri, 19 Jun 2026 01:43:36 -0700 (PDT)
X-Received: by 2002:a17:902:e947:b0:2c0:e7bb:9081 with SMTP id d9443c01a7336-2c71904bfdfmr30535395ad.33.1781858615850;
        Fri, 19 Jun 2026 01:43:35 -0700 (PDT)
Received: from [10.217.222.146] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c72089c377sm15930615ad.15.2026.06.19.01.43.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2026 01:43:35 -0700 (PDT)
Message-ID: <53b1fa61-9692-42fd-a295-98bbeacbcd9a@oss.qualcomm.com>
Date: Fri, 19 Jun 2026 14:13:28 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Shikra: Add DT support for ice, rng and qce
To: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Andy Gross <agross@kernel.org>, Eric Biggers <ebiggers@kernel.org>
Cc: Harshal Dev <harshal.dev@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
References: <20260521-shikra_crypto_changse-v1-0-0154cc9cc0de@oss.qualcomm.com>
Content-Language: en-US
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
In-Reply-To: <20260521-shikra_crypto_changse-v1-0-0154cc9cc0de@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDA3OSBTYWx0ZWRfX9sqJ8ZzIbBSx
 xhgvs+E6imZWjc2urCwiCn+LkwkWp2ELOUR54/t7SWWWTryfOP8HjXDoZIeskXaYdtEoS5jdjbN
 BlypoPBDa0QzJwJz+IVlkY6MNtS3caM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDA3OSBTYWx0ZWRfX5+3lTyfba/r7
 9cDFKRcjN7VF9hhuTKIJW5pUCrSYbXZAag3RcBbls5DrZjeNKl6sPXXwI112eLzUaEOpa4TJ1PK
 92IkyRy5zmwX9PkpEICJIZWyr6Vwjpeliir+r8duR1KNIsuVZyky5nTs2uyk/dGEijUI1uzphzC
 NT14KP30aWCLif16Vke20buz0FAYB92HAB4b2SWnqDAFKzPoDUmgUFCbiKBewO+mBCIqeSJhaLR
 /Ll6OSzphL+80B0GNQKocSBwlWQREpiJx0dNfUWoogDCCGwZYIOxK8tCXN+7BoPthNZ/hEPGXHy
 IqTimn16gMUPDQeL+hROhgdFnUrwHFkLKQfcE7BUdyRL41R+vW67p0ZQCSU3ai57cIeeR4oNkNp
 DQXYaY9s8nKDJW6cLDI/fk27EG4kEsfXTvcIN9gTB+7uuGuKfuiQhAcTmww5OSTxPeY3z/7boZI
 W2gvI15oWzgol+2aDog==
X-Proofpoint-GUID: M0mFV1uU0Po_tTIpA-fnPVhmoMycIFlm
X-Proofpoint-ORIG-GUID: M0mFV1uU0Po_tTIpA-fnPVhmoMycIFlm
X-Authority-Analysis: v=2.4 cv=OM8XGyaB c=1 sm=1 tr=0 ts=6a350139 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=DP-1hcgwhx0q92eQ_pIA:9 a=QEXdDO2ut3YA:10
 a=ZXulRonScM0A:10 a=zZCYzV9kfG8A:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 adultscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 bulkscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190079
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11638-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gondor.apana.org.au,davemloft.net,kernel.org,gmail.com];
	FORGED_RECIPIENTS(0.00)[m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:vkoul@kernel.org,m:thara.gopinath@gmail.com,m:konradybcio@kernel.org,m:Frank.Li@kernel.org,m:agross@kernel.org,m:ebiggers@kernel.org,m:harshal.dev@oss.qualcomm.com,m:linux-arm-msm@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dmaengine@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,m:tharagopinath@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuldeep.singh@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,qualcomm.com:dkim];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuldeep.singh@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 806E66A4ACF

On 21-05-2026 18:47, Kuldeep Singh wrote:
> This patchseries attempt to enable sdhc-ice, rng and qce on shikra
> platform similar to other platforms.
> 
> Previously, the 3 dt-bindigs/DT changes were sent as individual series
> and with feedback received, clubbed them together as all belong to same
> crypto subsystem.
> 
> Here's link to old patchsets.
> QCE: https://lore.kernel.org/lkml/20260515-shikra_qcrypto-v1-0-80f07b345c29@oss.qualcomm.com/

Hi Eric,

As selftests issues for QCE are now fixed[1], so shikra series should be
good to proceed? as your concerns[2] are now addressed.
I am waiting for merge window to end and will send next rev post that.

[1]
https://lore.kernel.org/linux-arm-msm/20260617-qce-fix-self-tests-v3-0-ecc2b4dedcfd@oss.qualcomm.com/
[2] https://lore.kernel.org/lkml/20260522024912.GC5937@quark/

-- 
Regards
Kuldeep


