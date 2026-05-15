Return-Path: <dmaengine+bounces-10480-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4IWPBXD6BmoKqQIAu9opvQ
	(envelope-from <dmaengine+bounces-10480-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 15 May 2026 12:50:24 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B322954DB26
	for <lists+dmaengine@lfdr.de>; Fri, 15 May 2026 12:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B44F310F0DD
	for <lists+dmaengine@lfdr.de>; Fri, 15 May 2026 10:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407F33CBE79;
	Fri, 15 May 2026 10:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FdG3Ib57";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Cx8TxuBF"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1DE3CB2C7
	for <dmaengine@vger.kernel.org>; Fri, 15 May 2026 10:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778840614; cv=none; b=nCizEo5Y4eVeBaRwWLEghzTFO5jjuznoGvCKNNUC5nGnnwf0o8iGVcaed4sfWHwDBaq3BTsexZlVwsc1F6fr5lmzUwDw0tnzDbZJQYNBviOlpKT4yE4aFm5MpPxcigGBY9S2Q926Hb9US+1ewQwypaMQUMN22FWuqiJcJ9UFWJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778840614; c=relaxed/simple;
	bh=pZ76TbMX4N7htg2RAI4fS928/r/GRKeHeguffESCJu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E0VwdvvGX9x8YAjjCemBPj/CnqPQWLkfCiscje4wv+NAStnq6IcWyOVb8EZyYDDDRpwwUS/J/AWRzL8G6CQ+xFHSlKbDTSdfpBbx1pKWL+dTP8Fw7waoXjP2dGx9y6EgJKHZrlpVN4HhjF9X8EWkAZTSwHVLm9oq8ykvmPUpttA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FdG3Ib57; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Cx8TxuBF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64F5Cb3K4008231
	for <dmaengine@vger.kernel.org>; Fri, 15 May 2026 10:23:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3ETCVPXTODOoocMFiNlNMTzzZGmzPrE9yEP2xRP19K0=; b=FdG3Ib57PELZQWuj
	24d3LAte8Mj3SW/VG5/T8cv+eugkwkPvDNOsmdUgjMVls6OFC6e8m1eWViI8dOJ1
	/NqdGTBfb/gFD38m+8sdjBUIEUsuXfzbsbxxt5oBfw8K2xHxZgojW0fuhnW7ziU4
	u8WiWFcJoIN9kO6jLduqXRv2thvceQU704V5ExgVHYclPDypZfQnGDNcjjF5bsFO
	slMmo4OnZGvooDmLnLZlqy2L4Nbk9OM8rEnpaFEL8Vpw+b8ALwZ7g0/IwHPrhkkN
	a6yM09+D77rVm8ENjxux7OFzB7U2v7oywtHc0b6P6Lg/dSFKXqrvJyXW7EWMbb1m
	7r+NXg==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1stu5y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Fri, 15 May 2026 10:23:31 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-56f8a5c02b4so745848e0c.2
        for <dmaengine@vger.kernel.org>; Fri, 15 May 2026 03:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778840611; x=1779445411; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3ETCVPXTODOoocMFiNlNMTzzZGmzPrE9yEP2xRP19K0=;
        b=Cx8TxuBFk/Ro5oZRnpRGkTpt4rJkrEVskDEo6ynd9YpTmrLTyyqsDjdDamUJte9GtF
         hAwHpacBDwFTgOX4JdHJdVKCen+wWCzFR0ppXKxzMB7/KUmEOfyVx04lUXYZsvc9hmI+
         QorQRolcao8v5c3frcYJ/BAV+D+AKiFu5+3X3rqcLWxY8j2jFBw18gM7SaENYcc2nuCd
         mxHW03+753bDiwdOQrBmh8C8AwzpwITrnXbtkt3ZB/GCaSK4OWZnld8z2Brznbw09pGV
         xRJo7OCT58udXujA3+cUbxSDItFdSWZd03B5bP8foAYrk8nnEEcK5oyd+M7R29aZtt6G
         /88Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778840611; x=1779445411;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ETCVPXTODOoocMFiNlNMTzzZGmzPrE9yEP2xRP19K0=;
        b=k1I6SQUjZ9roOrS+5BS1XAIT0ZZFPCKYr//g9PIZBe5cYDnrsjsIj5QXtyP1WDfo+V
         ZTunUOIuBvNjYFUmXsG9Sm+PE69M6+/zPu4QIHUICvu/AQk3gyK5piMjQ3Pm8v68bXqm
         meGp3doBrBaR3/zgIr0i4Fud76NSriEL3Kj6tOGYrpyJmLvlTR54BkcGlYpi7St1WqNB
         uV+o1fx4irBNR7ya1LKbrGMvedJtCSiaNzDo5NEDjJeytglq+nBp20Pz4Gl5PLNhSHzn
         juIgsnYlZ+HYRG6go6AFOx4lwvAPfYpl8+w0pQD68cV7jHZ0ifbR+7oEpqaBWhD2wn3l
         gd6Q==
X-Forwarded-Encrypted: i=1; AFNElJ/+X+CiYWAmF6YIx+l6Z//cAoYInnZwGpIb+T0cTquGJZq/bj9Q/otfUNYblpQBsojFirexFs0foXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoSnoX2iJopDe7PTXA26wYPk/FO2QDjrvmb5n9kds10DIeZMT1
	pHJKSN+P18n6/bwuwdAlSx/0/Td4Lw3EQ7pgvrQidp3kTCgEUmcThcCPbWCmOW4CpFQllcB77g1
	whk1P1h71VDTOD0G+aoYRQAaBalk7Z2ilj1nQwOtVDpqjeA0rGvpq77pAmfbuszA=
X-Gm-Gg: Acq92OHFznJg09ZjT6KJH+kvBIDbwum3XZpq3MzWA6r+/VyKMG8H2SPAZZh23HqJ7MX
	tCgh8bGtLdQiYOL4282Nz24Jk/l0TF1oHsubBc6WxXZ/nscI+M9IBIJKWaRM7UFFSkj9vlSzyLi
	s2d+kxDJu9sI4p3w21DMi4BnLOoXwHg600+rbTJca8FqP1N1DHU1uPIrOk5fpBM7Uw4WfSD+UL3
	unzchlhIWQGD/g0Dme6yrdjCj5HIqAvwXrg3e1cqCocjEAzB/aQWCWBeYvj4UgCsAtKIy5rurEg
	N6AAvNmBvYCe+Xdub1b2NUhhc9hh27b5+vzJosksC6OrTw6uschPBCUWqHzRtGceHONAHM58O1V
	PC56R9BJD2GSa3IjqfP438OsFSSziOzbOCR/m5mQcjjbBkhkbmOxNWDYBrmZW0okGNlae5YwQfi
	sLbTw=
X-Received: by 2002:a05:6122:4641:10b0:575:99d9:cd15 with SMTP id 71dfb90a1353d-5760be5c90dmr579437e0c.1.1778840611221;
        Fri, 15 May 2026 03:23:31 -0700 (PDT)
X-Received: by 2002:a05:6122:4641:10b0:575:99d9:cd15 with SMTP id 71dfb90a1353d-5760be5c90dmr579428e0c.1.1778840610839;
        Fri, 15 May 2026 03:23:30 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4bd1124sm204718566b.1.2026.05.15.03.23.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 03:23:30 -0700 (PDT)
Message-ID: <5ef3ccbf-c6f2-4d34-8500-b2de3ecc7de8@oss.qualcomm.com>
Date: Fri, 15 May 2026 12:23:27 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] dmaengine: qcom: bam_dma: Add support for BAM
 v2.0.0
To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Harshal Dev <harshal.dev@oss.qualcomm.com>,
        Arun Neelakantam <aneelaka@qti.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260514-knp_qce-v2-0-890e3372eef8@oss.qualcomm.com>
 <20260514-knp_qce-v2-2-890e3372eef8@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260514-knp_qce-v2-2-890e3372eef8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: gN8BsZ6aOmoddXmzOvVUWO3kvcaGKeWY
X-Proofpoint-GUID: gN8BsZ6aOmoddXmzOvVUWO3kvcaGKeWY
X-Authority-Analysis: v=2.4 cv=cZPiaHDM c=1 sm=1 tr=0 ts=6a06f423 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=0SJdTa_k44cpE2_h3jUA:9 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDEwNCBTYWx0ZWRfXxQblCanBsL6f
 Xogprh9kEZ24F4Hg7WBQjjvPjqiOhWH0REvh+qnGwloCWL2LmMgfd7COLXMHkaLqfhFFvhSsWZc
 Bw1V1Hs+STF1Uz4st+gwQW0T1gQPdEF9HkL8HmfvIuS7TvBAmDPja6N2sgZNm+7eRK+4gc4qJps
 PPuVN+NZrn0LfH4mStn9hsLHFy/QRd7XBJ4rDX1vrk/tWNHK9Z80/TNeEo/fHcJ0aHFJwN48cWC
 +Vsq5COLNwjKAI246ZXDDqDKBLD4JUDVMXLp5rgUlRA3hp/ix8s3t7cHaFZXcCfcANTrMGHwhZ1
 TLvOEXR39/bcJVwdHk4XOlJZu73AHddKhl9OOngiRPaK9zMDm/k+Atuau7s/0dwfWM2FCvkAVcn
 C6Lel2NB+apokyW5IGkxVLak9/yv42vzQUtOygmKlD7RRS/+gj4T1Dqxu1KM0ClmAe82sDN4Wr3
 o2PYJdQZ6eUGPLAk7MA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 adultscore=0 suspectscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150104
X-Rspamd-Queue-Id: B322954DB26
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10480-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 5/13/26 8:52 PM, Kuldeep Singh wrote:
> Add register offset table entry for bam v2.0.0 version found on
> kaanapali.
> 
> Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>


Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

