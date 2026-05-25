Return-Path: <dmaengine+bounces-10868-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KiyIrZGFGr0LwcAu9opvQ
	(envelope-from <dmaengine+bounces-10868-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 14:55:18 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E942C5CAC58
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 14:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2AD003019802
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 12:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3EE38331A;
	Mon, 25 May 2026 12:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c4WijiTT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kvXxRQpr"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD64382F2D
	for <dmaengine@vger.kernel.org>; Mon, 25 May 2026 12:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779713711; cv=none; b=UcZyZcrlB/q2KW9AfOuyPa9nF33NVv1pSN+vrBLvA7OIVcHlzRWBGdf2fve4sRZa/QHec59ZA5714JzbC3DlPHYueh3FNsPpYuVFoFbljauS1Y6JoVi9MPh155d/jWTe06gEFf7Kw2IZ6/YcNdFN/funxUPREKxTrfmgmVASkQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779713711; c=relaxed/simple;
	bh=jrPHDUm/+lT1kV/7BLXHI5qniXBpJQbPWvYor1QGy8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o8CVxDMgX/wWbysE3lzwx1k+zx8CNCpgfasoRzqRYea6iEAsSViv0kKotF3oI4kPCFrMVwqN2tkK7Yzu4nk4SFYy7naZT4cmGOIFxjG+8qkf8eAbuz/vYI0MT4sN7M7ixvnrT034aW6fUa/FidnumqETMSlOIfibkD64gPKqrJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c4WijiTT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kvXxRQpr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64P7J60O2222127
	for <dmaengine@vger.kernel.org>; Mon, 25 May 2026 12:55:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	V8RZuW+ZV8JwXDg+pkBPy+nHPlIxyE92twuTWRnC91s=; b=c4WijiTTAlmEp0+w
	/W9j6w2M5I4CbSLHhOQhb+GKTEYs6b/OyTaOphOP74L6RDMMf3sEf4JnH6f1Lb4D
	Gbad1SpCEyDbZNfP/3IEQKmwxEziephhfeC6gGKPOxzb3Ix4mIXvPXJV662XC/1p
	gnf9FCQfPD8KVVAauCuWkLJKmnR4m3jA11oKs9BYn2Xca7R+8vo+f77CfwNKuq+l
	BvHCltqO7wwY/JKd3jpNZgfBKOhYoyuxZ/oc9AGEyXVDa4/Ds3/meBl29qAIaeS9
	ohsd4NVxhiPI3Vdeu+MvPhm8l6uqv50zNVH7lXYN5l6Wj3aLA1xl62uM32hC74Pv
	onstzw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb4m7pnfe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 25 May 2026 12:55:08 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-90fef17f6f5so214546485a.1
        for <dmaengine@vger.kernel.org>; Mon, 25 May 2026 05:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779713708; x=1780318508; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V8RZuW+ZV8JwXDg+pkBPy+nHPlIxyE92twuTWRnC91s=;
        b=kvXxRQprFh21m87JzIZHdzrslb1EVeRg+FDQLLY1UZs14BhoBo6JfmtcijT0HoifMu
         woJmWQk47P2iWqace2TfImQ9kopGb4FUyo+FQJTUEGZxnt5EfciCKvd3YyK8JYj/zu0C
         kbUKbaOgRMqZraNvm9t6rlIlNjCFixfNKwaA/bNqZbQ1vlZmC2kZoAueTE3+D8EVMCEt
         PGXmR9yukg1jzeMerTaHL5TPj6mdjRaB2KWZv8b+sgyU8MiAiRzXXoev+l1uxzLJsKtW
         EDECNp5Cd8Jg5ADfBT7JZv4J2OxW+JOOuKIBer64+4lmuq54pLBqSWLu3f8DvRAK6ADS
         wNSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779713708; x=1780318508;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V8RZuW+ZV8JwXDg+pkBPy+nHPlIxyE92twuTWRnC91s=;
        b=jak3kmmvmf0wWg3tQh9I66u8WkI/jMoUUaQCK1QTkcggM8+Lqlyxc+Y8AitXxWz5gf
         g6uAlSSNb5EgLY35hniUyABbVtuxQDXtVvS9QXZf8Q/3UgM1tfpxWAFrFKGc3fxY4tcV
         h2yvDzFs/y6yjEXIvstxZkGvBiopRjn7dE9Vi9UKZb0VaOLSU3BY/Gj2Q3lxaLhFDFhd
         c4Ylkv76q4f0xQinyhsmYyP5dD/dmSvcRRTgj0+BnG92a4pnOZ+zQHGprPc0wnyNRan6
         /msSUNceFjdacoPNcqIjfSffyjZKVU81Lcuct5plIw3HbUWBmewwbE46/sTUoDC7c7R1
         mbVA==
X-Forwarded-Encrypted: i=1; AFNElJ8qEcElwYBBZMCe0jDJCkNVNR7Hrmcp7Ap2THuWwkW6niB56KSExFT2Vo5DBT/Q2nEuqtLwY/+BrxM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo2LZiuQZql60ceZpj4TjYjIVvFkgasKavOGSKHtJjdczV1Zx0
	F/MT3RnePMVCnclucKwD0OQC6ltYUt8h67/GE2gK3fvKGDGh2+IsAVBQquKqceSU5YITnKRLx76
	MxXClnxTeONavmRdlhlzcqg4F3l+WxtE09rSp9UziiC3Qz+wIrB+xbtH18AC2qls=
X-Gm-Gg: Acq92OF5PH8sJMyJfIYVi43fcxYOq9SLkWf139FGM/8r6EACqpcyCMw5eA6n+i65/mq
	E/fQIfQNMqlCGiLbUn4YkVET2M2x0FO7kKdAxHg3bzSWQQk/dcZS+x8XLlGtjyWESXSyFbUmAo5
	cPU+PmzBUC1TTUjDWAxZYaj+vCcjWSlLHUtM6oW0SbuDj0e+8UocjlrhLvW6JeBcD3ppd2xRHbA
	VdjoSicMHI+WQaMANL5JIfBiirvOVV7HYjn2ChJmsiaSMPoXBOArlide5bBPr0J/UycS5T5EE6V
	vGpPCev1aGUidAkLpx/uejWvidAPO3KdMIEkhrAxycxuDla80Nw6Ty90AoeAya9+DboSZgrpg9e
	t6nBBp20PrtzabdCgNolokyd9XlvZMM1HP+kZxgaa19xTCw==
X-Received: by 2002:a05:620a:6230:b0:914:c589:7945 with SMTP id af79cd13be357-914c58983dcmr702815585a.2.1779713708472;
        Mon, 25 May 2026 05:55:08 -0700 (PDT)
X-Received: by 2002:a05:620a:6230:b0:914:c589:7945 with SMTP id af79cd13be357-914c58983dcmr702812185a.2.1779713708003;
        Mon, 25 May 2026 05:55:08 -0700 (PDT)
Received: from [192.168.119.254] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bddc264feb2sm397057366b.10.2026.05.25.05.55.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2026 05:55:07 -0700 (PDT)
Message-ID: <78ce80bb-e8f6-427c-9620-53ae1edcb3e8@oss.qualcomm.com>
Date: Mon, 25 May 2026 14:55:04 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/16] arm64: dts: qcom: shikra: Add cpufreq scaling node
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
        linux-pm@vger.kernel.org, Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Aastha Pandey <aastha.pandey@oss.qualcomm.com>
References: <20260525-shikra-dt-m1-v1-0-f51a9838dbaa@oss.qualcomm.com>
 <20260525-shikra-dt-m1-v1-4-f51a9838dbaa@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260525-shikra-dt-m1-v1-4-f51a9838dbaa@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: d9aTmjnUScEGoxicd7UQG30D3zOtPGQt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDEzMiBTYWx0ZWRfX0CBhVW4Q0RGh
 o3akc3Jo/aNeub346MQKwWe2zQDn/DePQf0WJBPqhZwblrC3Kj33e379wzQe5AJllQvLCE609Dc
 TH2Pk7t+C8VyoOvP9D0D6F2nvjErmZMmnwkDgnluR67zXTlk7SZyXOq0U4itovMGHaWhtsAffbu
 FzCbkRtVtQzh3PaRhR7SasF7eFYjCos4KdL4jN8xMwD8SXFprnpUCRKNOCV7yhqrTehHLlb9Rpw
 uqkm4JGioSxLz0YJV0nMzwHIZXYiIyBTh2MFCDciZZZEMsy4ENRfGTJMO47lOA1OXgKp6/PG0n6
 Shl+LuXdz9Xsph1jOkxj4z3MCcdt6G1zUzuALGtyzL5EMd+lGEPXE+FUc9hb2Khj2j9kWtJh9Sl
 nYWT8GwW0N8qJEscFRlSSH4Ywid31gnVjR/GkK4BwBfQzUPmf27c4vHxviqsmZ9CpXihkyBdmwu
 pojWEd6sdDkn/Hs8w9w==
X-Authority-Analysis: v=2.4 cv=MrJiLWae c=1 sm=1 tr=0 ts=6a1446ac cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=gR7PYC-x2pxtVi67x8UA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: d9aTmjnUScEGoxicd7UQG30D3zOtPGQt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605250132
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-10868-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E942C5CAC58
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/24/26 9:49 PM, Komal Bajaj wrote:
> From: Imran Shaik <imran.shaik@oss.qualcomm.com>
> 
> Add cpufreq-hw node to support cpufreq scaling on Qualcomm Shikra SoCs.
> 
> Co-developed-by: Aastha Pandey <aastha.pandey@oss.qualcomm.com>
> Signed-off-by: Aastha Pandey <aastha.pandey@oss.qualcomm.com>
> Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

