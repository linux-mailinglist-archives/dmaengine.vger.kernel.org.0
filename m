Return-Path: <dmaengine+bounces-11870-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RBOqMpSGQmqY9AkAu9opvQ
	(envelope-from <dmaengine+bounces-11870-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 16:52:04 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C932B6DC4E3
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 16:52:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=PTnjNB9X;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=NnvG0nc+;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11870-lists+dmaengine=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="dmaengine+bounces-11870-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D87C53018ABE
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 14:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADCB41C30A;
	Mon, 29 Jun 2026 14:39:47 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20A641C317
	for <dmaengine@vger.kernel.org>; Mon, 29 Jun 2026 14:39:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782743987; cv=none; b=edWn/nA+a2z6xYZ4VgFX26J6f/n3HHISeoVAJpugYVVL0IbRkfgXbT3X7OePwpX0BAz82TVcauEQmRIw/wu64WgTxHdnOpl3iAN5dCZ7bPTgu4dVtZcErvxHGfBMnU6V74YS7tAUzGa4XPejhyKhcFeClq7lTWg1AcEAOatV0TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782743987; c=relaxed/simple;
	bh=liqOCMe7OXo3zkQgVlcw1Eu9AkfS2Wd8nUtDi/XIQpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eoi28D/KpVLSF7Bn0La0kiz3K9Pe8GUk9uYq87tnY/LWAAJJvqza5EKTI4wmYg7XofioeVOXjqE8cdagIs6zruuIIq1pvFMnarbn0oXkdDYwf7YJ028k5lnNQ47KKHkUPyOLFSboaV7x5Kq9GGievHaT3mL5H1E6NUZaSVOS81A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PTnjNB9X; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NnvG0nc+; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65TAT0iG2641507
	for <dmaengine@vger.kernel.org>; Mon, 29 Jun 2026 14:39:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5bbBHtidWhRPmnInLMwZken1KORMptwNsSz5+Ls2hA0=; b=PTnjNB9XAbMirFlE
	ndJIFRNsKyu6sxsLjqv+9bRKNiPVTf/hBFDVxe2UEejUOn2LQrHHBd9wZhajwVbv
	wTotbYxEKMU1fO9xaDJDDciJCM3WyiKRx4pxw2d4AUQ7R6Rq5k/HiWOIYo+zAmAA
	KmrhOQdGd26U/m7rE5BqRONr8l08AjDp8asqoLZ5Eeps2DCmDCqb4mi/LR/3cC1A
	dSHsDdFFi3ElSt7QrnXeaAyQeDgImOejXoO4dfBTe47Csvh0nymhNZqeaJ10IlZz
	D+HczX6IfotlQ8S+2VU0DCy1mJImtyqz/Rz5wVKzwZJb1wZHpbGB0bi4FS2rFYJ+
	1Vx/Hw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3npesb0b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 29 Jun 2026 14:39:41 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92c326f6e7aso82436985a.0
        for <dmaengine@vger.kernel.org>; Mon, 29 Jun 2026 07:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782743981; x=1783348781; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5bbBHtidWhRPmnInLMwZken1KORMptwNsSz5+Ls2hA0=;
        b=NnvG0nc+W3NQhTENNoZ64kIF4WCjBPYaFFbgGSUWRiRjlWKq+LXgfkLjUf45scGSRV
         kOkbeUSxIIGSNSZLHmXeZurQq+aCiQHyarUzCYhXyXeEiz6KrzWwWdxF8r3JPH9rBiUH
         NnZ7UPHE1EsGF1PSkikZ7bjAkDXKGu+eUj7dYC8KzdofcJEkauVR/FnszqMHfczJ4ZSa
         WAqexQAtkdqsL2ZjuRVgPVHv7gQ9sKTF0E/gLBO+C3/fbtl4T724u76Ng1LDtzQimFTU
         nIubUD6ac8XUhfCRrjEc3p5tnN/CdEDw4BG1zdyjHq98bybHNBQLyvAX5aNYTJsaJAiP
         /QeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782743981; x=1783348781;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5bbBHtidWhRPmnInLMwZken1KORMptwNsSz5+Ls2hA0=;
        b=DHVN/74FxVzbse2ji7pwKsL1CQJfN/pH+56UZODPNdbMTTf9tvpPfK41hWglx1IMoB
         P2ZgtXVOh5zLpxk3jbvaKXy+iC582WfirlpvTSW/b198lC55cRM8ORayNKjwN54KPeVP
         frGh5atoyzWG4vVT+pT2T5TwK/U+Ie1V9PYDRMf9fbEPNqIxKkxxSyE/fGUG0VjpbjCW
         giZSMN52HzMnAYfh7JWuVvyvav0PocAQeHoXKe3r1rXXX+bTWxC1XcfhFAWyeAAYpTgj
         YKh6Yn2D1g4tlSr6/VHN0XNbXiKTT8ztTIEPYfKqO5DOzgd3/Ko5JjpGEmiE8E2LlPhV
         201w==
X-Forwarded-Encrypted: i=1; AFNElJ/JAbtex8cYCw/oJAp/k0tTYTfXaCmB6xJvf8oEAxYhLkZBX8taj5nWK+uB5HrGSN4FV/CF0VzebS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwID1deDicni01Q0bRtju1cQwUb2caWF20xOUCPumi9YlyYAuaA
	L4JFSjAy1qTG90mIStJ1ybUxKHL0e8hslr6RvuuC7EIGgRPnPHH3vA4j7gTh5gNmG06bAhnBSw+
	34gUROrAhyja7m9KRpDH0as3T2QPElVJtT4+0XrpARbv4K09a5vOOVkSONf/9mD8=
X-Gm-Gg: AfdE7cmwijANtyWBKSe0ohWq2NOJv4bCVQRA0THA2EOduzoZDU93GDh2CYfOuSI7HO2
	6t7Lwax369WuDM8LUGFFPWypT5ol4irgnOBjLqdma0KV30pTEEQjPkQENiWiX44EDYNA4vJsWsj
	x6X4GUFgLHO9zmYS8IqOipqygXpisCZAj5QT4pR7aibnvJfbXRXWs3b5TjthfOzFPEf6nM6em+N
	JRplWda0bAYHUOv0JVMgvwv+sGt9DLM3l7KCVGNbGYAnFFxvX1jK3SB7CfV5XIwuKclVtgNvQ+5
	CU5lBqC8GrdpiCdpTneM505cacMh23JXB2qTdKwJ9n3fzpf5hvSQb45yn1ntmuw70vhDhWDYBpc
	i5daiJxcRnOggUBtGOD5F18rNpmS7JXB0d8c=
X-Received: by 2002:ac8:7e84:0:b0:517:57c1:bbdc with SMTP id d75a77b69052e-51a72a8dc41mr164992911cf.6.1782743980691;
        Mon, 29 Jun 2026 07:39:40 -0700 (PDT)
X-Received: by 2002:ac8:7e84:0:b0:517:57c1:bbdc with SMTP id d75a77b69052e-51a72a8dc41mr164992561cf.6.1782743979990;
        Mon, 29 Jun 2026 07:39:39 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12376df39asm449075466b.16.2026.06.29.07.39.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 07:39:39 -0700 (PDT)
Message-ID: <021fa1fb-7033-41d9-927a-5322be71768a@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 16:39:36 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/10] arm64: dts: qcom: shikra: Enable CDSP, LPAICP
 and MPSS on EVK boards
To: Komal Bajaj <komal.bajaj@oss.qualcomm.com>, Vinod Koul
 <vkoul@kernel.org>,
        Frank Li <Frank.Li@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
References: <20260608-shikra-dt-m1-v4-0-2114300594a6@oss.qualcomm.com>
 <20260608-shikra-dt-m1-v4-8-2114300594a6@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260608-shikra-dt-m1-v4-8-2114300594a6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEyMiBTYWx0ZWRfX3+PYThUzZhR5
 /qBJXUcp+5Wh8PgAemrSkBo8p9SAyUKfXeaUiFDQNWPt8qzF0OzNag48JxX/vzLGEn1kW6rbQB4
 JhHiBzeJGMPY33O6mibX8oVV5iWrXKFGtndEwzuUF7+Ej/gUsj6TSdIiL/w7N+PRB7f2CyZh0YB
 1e3ZWxOtyRb+BGO3hF8u60acDBLWx4ydHHANwZhR4KS+s5UXb0CzmIPJMe9piFdRSqCxd2Q89Pc
 f1J1kI18lJODgW0pjF0OkJ18OZl4EHhFbl0wmg73tYZaphnYJT6zfcsogVw3IxY0Q2kj0LqM2/0
 My55pOoPZhMKmVcDBQ0vvSQ4iXgTEVwcmmOb7wo0v6aWVzW9OqPIWW5N4PAQ3iyDP0xXN4Txs0S
 UV2eKfNKt0rT8jkpRTDPB9+o/0MAJ291favtwYDMKKZQzYn6N3bI1qIvK5PlIRz/+qxh9mYhI/d
 Ms+HJFX5EUcISYbkOsQ==
X-Proofpoint-ORIG-GUID: 4vfoMnydSnXdL9pu144v8KeaGKKY6XYU
X-Authority-Analysis: v=2.4 cv=T6q8ifKQ c=1 sm=1 tr=0 ts=6a4283ad cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=2wNq6JH_cIzNK18R0_EA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEyMiBTYWx0ZWRfX7jwS9M8ubc68
 mkcW7e5DtgGqk3LDabhW5BxUmrZsD1kWKn74Ubcw07kyWoFcFsLrXlNdyOJLQkGnk39Lvg+kDjT
 BxwQtIdySG9ywwPvx607iQGObUg7Q5s=
X-Proofpoint-GUID: 4vfoMnydSnXdL9pu144v8KeaGKKY6XYU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290122
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11870-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:komal.bajaj@oss.qualcomm.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:krzk@kernel.org,m:djakov@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:linux-arm-msm@vger.kernel.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pm@vger.kernel.org,m:bibek.patro@oss.qualcomm.com,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[konrad.dybcio@oss.qualcomm.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qualcomm.com:dkim,qualcomm.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C932B6DC4E3

On 6/8/26 3:10 PM, Komal Bajaj wrote:
> From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
> 
> Enable CDSP, LPAICP and MPSS for Qualcomm's Shikra CQM, CQS and
> IQS EVK board.
> 
> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> ---

[...]

> +&remoteproc_mpss {
> +	firmware-name = "qcom/shikra/cqm/qdsp6sw.mbn";

I think cqm-evk etc. could make more sense but I guess this
is already shipped, so might as well

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

