Return-Path: <dmaengine+bounces-11960-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EDCYElRLRmrcNwsAu9opvQ
	(envelope-from <dmaengine+bounces-11960-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 13:28:20 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BA56F6B14
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 13:28:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=gZaEZfuL;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=dSPoTcVi;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11960-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11960-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 900EA30696E8
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2026 10:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A793A4F5F;
	Thu,  2 Jul 2026 10:59:46 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E63F3C5DDE
	for <dmaengine@vger.kernel.org>; Thu,  2 Jul 2026 10:59:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782989986; cv=none; b=EOTU13415vC2t71DJDrgM58K/52toHmvPnUUa3BGaDD04guYr7fEKJTBgYzry8VvQK8ido7LWKbtWZX/iR1qQ04C1CAajVQmbuU+gn74R+u3rRfqaDAErVZrRzYAHv7sNK7hLNzUkSdQtA4BPP4SaLJjIWVybOl43tw3ozqIxYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782989986; c=relaxed/simple;
	bh=VyTdXY+0+wvH6hvhv1k6KwriSQSnFo9Ih756l2s+Zfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o4/xn7EtbSVoVsmUA23V+JKvxs2xQB9QaCXZoSpj+BvFNou6/7xo3AmQp+TCYAzQ5nb9XqZwcf7+6KmPJiAtKImsHjnx/7aOP2DoyBwv7WayDWzoZb+gP7yt2giBvR9PlwVAvsyvgGAIpaaSj1cNrbed3WK7P6ljinXywGcEyXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gZaEZfuL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dSPoTcVi; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6629KMQq4115608
	for <dmaengine@vger.kernel.org>; Thu, 2 Jul 2026 10:59:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	T8l303crY05X0SOko3/98TvkP+K410TeNXuDoKahb7U=; b=gZaEZfuLBvPGVhEJ
	IW/rB2RpgDRswRjdoN26w+mpsSW3GAaL6dR521F9K4XwGtVMMRwE5lXPHlz6nBaT
	oN9YIPvYYxrkBoO3mmqcAM+octSyx4ehBOwZhiUsdyJHFpjOnop3JaBFis8mYGcc
	hteKyzXGrkuzjR4qU3zQqdN8oHBh5VyUq3HS0Tvw8iugeGsdkldzGSEO2FfxtA+5
	PhTT5zfTGKTiIUpDxWwBffTfO28fdG1PO9AR5TXixz2LRX2l/3AZO8S7S/hbyD7a
	ljC/wOdy48nMUW6uFC32oseN9mnfVNlxBwb/8lMBRJ4lA/4r+HEZ8as0tfMcaiT+
	WH9qeg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5n940bpy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Thu, 02 Jul 2026 10:59:44 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51bfa45b280so3376331cf.3
        for <dmaengine@vger.kernel.org>; Thu, 02 Jul 2026 03:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782989984; x=1783594784; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T8l303crY05X0SOko3/98TvkP+K410TeNXuDoKahb7U=;
        b=dSPoTcViJJE91Q4C6VrV7ujzJH10P0/enhNGjfTEAYs4LE4m/d4B8grexpAy7AOkqo
         rnZr0KMY4o5BJIG0fG7IRi1GJYzKcEAJCrl4UFv/yU9Qqp70y8z5dFbGEMeBgWFlylLZ
         5rpNvShp3zd0E5RjvLwbSDfNyo5hfvjzfEqE6m0HZxs+4hLZQj/wr3O0gA2+PStgfcyy
         ziTVqgTZIbcx4jyfSlQFuXpxPMmgpL1daN6ElPAQuvAyO2JHk0ra6sFpki8rYRxztgWx
         etlGkEOthe8utfjxqd2xhgMCQ936LK5h8UDPStbY9EHdaYpm2E1xrzzoWn8WTe2qD8mk
         OT0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782989984; x=1783594784;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T8l303crY05X0SOko3/98TvkP+K410TeNXuDoKahb7U=;
        b=XnmUCLbRqHcdOLXuRS9Y1s2fz+pMEGxEM1nZGYnBOsIbX8nuGM4NjM5I+05HbEGKgt
         suiCAF0q8n8rOp33BDk3+uLZKMdV9aEC8Dz4ASPD5et2/FT1KhH53O3cgUvBpmkZlbrs
         1ykzIMathlA16ojzQtHHpzm/biQ169oxjeZzb04oF/u+kz0In8p0/ulVQ27IkDJtNLzG
         21Z99S54ncg+4eSHHMRKCMUQ44D8VWQo2sDbd6JAg6OqJO9rL2Ns1IyShJM8BPEOX3a5
         4BpVFMV5GMBm8smH1efOEZblSguRQHSPd72VPeH2ochzZMdeamWnRASK3KDMsWaYHIDr
         MwbA==
X-Forwarded-Encrypted: i=1; AFNElJ/laryRci6DtzMFgCzSoEhCUZe278vPDt3dcm0eI2JgrZKSDV1/Z1I594798GtXoaXa5Ba9QvbtibI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYmHvCvi2UD6TQkSi/m2BfGYzli8nOJlTdd4H8wZNMuCSa840V
	6ju90h6zxLzWVmQ25i9Iu1Zf59GtYIq73acCIVrMcGAlmwUsdcP/qH552EnThX80ARwlMbI+6IM
	gtXPktX+8cqH50weTy+hVROhMvgCD/eGJoT4BAymVhtQvbJX6l2iLHQT5FFx7dVQ=
X-Gm-Gg: AfdE7ckYCpWaA32Qnc/jb+TIZt3j4ox3HiT05256MPi2pT1P6jbaGINN41H2eYPk9AP
	OeZIb2U3FUaXpcls7YqzzCbSGVnRvo21FnS+M7VmUfrG3FGxy6faykWrpsitQRSOgy6gs43lKli
	ESOtd1w8/qM7CVm+9yk7hNkwyZJ6XSwCWAW4D+fnHjSqZiVjxGXscyZpIHT9KEA0VyxNkZVh46U
	DbZaMUqXgQ8stETc+RsNYaQfIr/TdSEZiRxBigXn/gDfpi3NmjsD3Nv2xzSJs+a3AmkjJgXkleN
	VmwUl1wiFpxNUzhdZPO7eQEVNBOtBR5dBtp/AyyY/lyND3mlqxkLFkXAO1LwBEoT4dobxmP0SpH
	zAdnplgqgFmkfrBGjZRowm4MTJWT4xguO52A=
X-Received: by 2002:a05:622a:3d4:b0:51b:ff1a:3d80 with SMTP id d75a77b69052e-51c26b07996mr51310371cf.7.1782989983787;
        Thu, 02 Jul 2026 03:59:43 -0700 (PDT)
X-Received: by 2002:a05:622a:3d4:b0:51b:ff1a:3d80 with SMTP id d75a77b69052e-51c26b07996mr51310141cf.7.1782989983368;
        Thu, 02 Jul 2026 03:59:43 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b6290972sm112872666b.41.2026.07.02.03.59.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 03:59:41 -0700 (PDT)
Message-ID: <0ac50f09-8a62-4735-99e3-b8e632621ed5@oss.qualcomm.com>
Date: Thu, 2 Jul 2026 12:59:38 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/11] arm64: dts: qcom: shikra: Enable Bluetooth and
 WiFi on EVK boards
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
        linux-pm@vger.kernel.org, Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260702-shikra-dt-m1-v5-0-f911ac92720c@oss.qualcomm.com>
 <20260702-shikra-dt-m1-v5-10-f911ac92720c@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260702-shikra-dt-m1-v5-10-f911ac92720c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDExNCBTYWx0ZWRfXxbavn1xi/zr8
 m+e1jR0z9ep7e14X9sivQkCdQVJFIrZgg2L6y3ZUtH/a6dtk5STjC9d2HNwMonYiPfEfHan3h7b
 Z4wx8ALxEAAk/IOdMRJzqnFLdHIM9UlMcnbrIOrw7y5ZySxMvkAdUlbGbbLt0OO5PIx6v8OVgiE
 835gQu83IESP6iOKExRmESzUXHdfC4i0nLF7MoVUuI0iN5TYiPWQdMOttWtq8m12R5FDHxSb8IP
 /jiCdEmLuKpbTjmwJ6iCuS8i2uyslHnGo/bsF3TEmP7mLxSW2+v0EpXOQmprC7qxyPZMLUpINAI
 4rDhWmJxoS+XwPsQTUHvcptIBK0X7F7qMFlQZfKlZEFuYIBUTCWg+Q9WU2T+En+D06jtBr3btDD
 BD70nEREhrMxKhj7GBnTLV+S3utrhlffiil1lw+B3YVT3aoVBjkN7Qajtpq/fpWkCuOiAUg2mFC
 6f/6OuGj+cjpe3YJ6Dg==
X-Authority-Analysis: v=2.4 cv=Lv+iDHdc c=1 sm=1 tr=0 ts=6a4644a0 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=pm3H3U3sixV8GkyNLbAA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: los2poPiHifs1qjbHz6jiUA5E0y2PCkU
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDExNCBTYWx0ZWRfX/najpOuHcvCX
 Chr3ePvEf8Ibb+6Y6YAI7Yp/nJYltUV8aW/Q8w7UsgISImSfaD4ox2C3vZLfzYZCSMlILwaZ8W5
 GFIbqvuLuSU+r5dyXx98TGPWk7X14zo=
X-Proofpoint-GUID: los2poPiHifs1qjbHz6jiUA5E0y2PCkU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020114
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11960-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:komal.bajaj@oss.qualcomm.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:krzk@kernel.org,m:djakov@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:linux-arm-msm@vger.kernel.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pm@vger.kernel.org,m:yepuri.siddu@oss.qualcomm.com,m:miaoqing.pan@oss.qualcomm.com,m:dmitry.baryshkov@oss.qualcomm.com,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[konrad.dybcio@oss.qualcomm.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:dkim,vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 04BA56F6B14

On 7/2/26 11:50 AM, Komal Bajaj wrote:
> Enable Bluetooth and WiFi connectivity on Shikra CQM, CQS and IQS
> EVK boards using the WCN3988 combo chip.
> 
> For Bluetooth, enable uart8 and add WCN3988 Bluetooth node with
> board-specific regulator supplies across CQM, CQS and IQS Shikra
> EVK boards.
> 
> For WiFi, enable per-board with the appropriate PMIC supply
> connections and calibration variant selection.

[...]

> +	wcn3988-pmu {

Override by label, this works but it's super fragile.

[...]

> +&uart8 {
> +	status = "okay";
> +};
> +
> +&wifi {
> +	vdd-0.8-cx-mx-supply = <&pm4125_l7>;
> +
> +	status = "okay";
> +};

Since the module is on the EVK board itself, push the enablement of
these nodes there too

Konrad

