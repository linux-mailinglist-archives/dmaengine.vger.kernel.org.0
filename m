Return-Path: <dmaengine+bounces-12551-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6g3cLv98V2r/KwAAu9opvQ
	(envelope-from <dmaengine+bounces-12551-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2026 14:28:47 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 430BC75E1DC
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2026 14:28:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=p0WOR4hY;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=HtUN93Rt;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12551-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12551-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4ADB4302E426
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2026 12:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B22466B4B;
	Wed, 15 Jul 2026 12:24:23 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D8744CF56
	for <dmaengine@vger.kernel.org>; Wed, 15 Jul 2026 12:24:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784118263; cv=none; b=t9QNapZOCDjyAxy4l47tdwSz/bRV0OmoKCMNUB+0FtK3V/wGrwix57TRwkKfUyDs72NDmDBlWwDUXRSgO36PRnjiWIDC+mHkLR57gMGR7SNZ5dUjJRILUp5wEstN20b46MBVeBkVwuiB0EsjzX+u471l2eh8LG08Gm7YgE2q8dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784118263; c=relaxed/simple;
	bh=OiLW0cnorrZrBTCCbegC1HCSXh64/IHwTXjkwHMRpLo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C9XSoXGs8laZJdXzGfzGr0ChxX9md3PdyxQ433hYoFjoxQPwAm0jpD1i2vOEvOHSwVodfb0LqCwSMY1iYUBD8cIWzUsKmJTrbAKxsG0YQhY3aGGUPqDUnIbQKQI8Iux2v4ubV+qVRGpHk8IIvQUwCDm52jQPd10hCY1YQGNZKnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=p0WOR4hY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HtUN93Rt; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66FBco4q3628750
	for <dmaengine@vger.kernel.org>; Wed, 15 Jul 2026 12:24:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	n+6U+9HLnuGImDd2MqcA4i8jqmVqmZWZIAdVkvw4LYo=; b=p0WOR4hYHW07HL2k
	OV+sr65xB0Q3FJ8TzTpGqbWYF3U5KjEKy4RPuE/muoVvDosiK4LDWr3oAYe0UdnO
	xB9OSs/hmQneWnIVxJE62bH/lDvjuufoJoXlPJD2XeBgkT4dEkLcrzLrFOmNxX0D
	xzijU/5Ihrw7JXDkUfPD3395jWEguz47346Vf0MGrzoLJOVWQ5hJrlwyWPnw5kWk
	S6qZ0++ZJo6TagxmkbckIubPqNs68ZLfTxze4D57WZddVNKb676339esjExKCYZM
	Mhrb8dBX0P66kEmeYRri1S2p1xA7slESSpOqAMDSoVe5BtaSGk7S1womcJGI+zyh
	zEO/Dg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fds9kun1f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Wed, 15 Jul 2026 12:24:20 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e4ecd1ae4so89498285a.2
        for <dmaengine@vger.kernel.org>; Wed, 15 Jul 2026 05:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784118260; x=1784723060; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n+6U+9HLnuGImDd2MqcA4i8jqmVqmZWZIAdVkvw4LYo=;
        b=HtUN93RtdEMX6Im1M70TvXS2eNSeINDQJ8NzrMnCsIKpFzW7X9heCPBnh+uBMSxErW
         2+cCTUUO9A0q8sBZdIIXXEsA4Ro7f8b2ENiQ5I2SgY4z+rzMJDcWUE6vR5g6uDST40nC
         qJ1lTdTqqxhidDOGzFMqRN/paTkihY/6yOlxURomh17mLHqSc7gvcRIH86OAgW3Scxc3
         GdgWGRvhJze9vWPuBGVCh9lp62YpOcnIGNlm1gy5b0pvXuKwkFfftZ8CpKYPixkunJsl
         12z3/wwIz5Tpcn7jflTkhdHKiwwZr3uQxk/2JD6hiWhy/YA8JAeUYPs2gnZ7HES2MPgB
         L7XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784118260; x=1784723060;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n+6U+9HLnuGImDd2MqcA4i8jqmVqmZWZIAdVkvw4LYo=;
        b=HhQ2Z4uiotiys+foV00hCdQafXIr9AdftU02YkShg6YTEiMZAr2Njh/+o3NaWYv7Xe
         77CEM9B8FWAr4IQuDA4qHj0FfbSZD5uz3OJBYKg5O6ptD9yL/ZUEdFnhx0F6UIjSymGA
         8uHRg18RvNqXFryCoiWs2PU+SHR3AP/ZGRA3Jz7CnkMpxn8Ng+28U/2ZHfw7uay2oOrf
         usrqgSuJACdcEHWjijube82LAYdwn17SuQC+GCSeXVaEFHnRGpisHXCZoMIi/ORM+Zd0
         A4D1tYJ+RhUqHnIfLBT0kpkqLXihVW500Q6YY75N5MRFCtRkizBlLwdXvRaWeDLYIa1D
         KoTw==
X-Forwarded-Encrypted: i=1; AHgh+RqVdBgyleQAMDtavr4tFxP7x72a6R55N1HQMd+bl0+VkQFMb4GnKX8bfZAL6iS6EY6M0/98atts5Ss=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzEY85SmsG90DU4aaKrmNdM28ytArM0i+92QPUtbB3TIb6Awy6
	vjR5rICcvaLx3p+JysDOGdzOIihPb/YwUiiLbzO6EspjL7iyZKXnUvGhHl6/am3lkgYN1Qmr/VO
	AdHHaFgXS8CiA/JaCiQbFoRIoLPJwupHO00PIAHRVhnjKc1N5pXgCjqxFXM86Wtw=
X-Gm-Gg: AfdE7cl0y5F68DTJGxP02+Q1VyWwmqeKNQgdnQknILthdY/LtOUiFiXriPfgT9Da6L9
	O/NAXAUhzQYpaZEuTnhb9jAdOlCdsUjCe0El583buO+bu5EDPzKKF/AgMGQX6tKD38Zr6DtYmZQ
	AXHRCYFhLH0rl9+mKrpgWdwzURqC7n2zYducbxtA5R1GbMpLfaj5Z9L8xDd0+wvVHHnRmdDF7dZ
	opfeRKhyK9E2cLETereif5b1HvuYbbOSqQoD7nzdfOByzKVduANig3ZosKc/C5PlPwMnMAc9E/i
	Nubc0k/wHbXrYcdv0vf1P+5MGaEhpFATR9WlxPRML24xB1gTlqt4gGWQj6gTod2yuKM6pAOejS9
	RZ26KXwNQcjGkXsD9Q+bE+lq4gSaJcowX22E=
X-Received: by 2002:a05:6214:459f:b0:8e7:d237:4aa9 with SMTP id 6a1803df08f44-90403d516e3mr172365856d6.7.1784118259761;
        Wed, 15 Jul 2026 05:24:19 -0700 (PDT)
X-Received: by 2002:a05:6214:459f:b0:8e7:d237:4aa9 with SMTP id 6a1803df08f44-90403d516e3mr172365626d6.7.1784118259369;
        Wed, 15 Jul 2026 05:24:19 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69cd287882asm2931930a12.3.2026.07.15.05.24.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2026 05:24:17 -0700 (PDT)
Message-ID: <ee424097-6f29-4605-bd0c-242190a7b376@oss.qualcomm.com>
Date: Wed, 15 Jul 2026 14:24:12 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/4] i2c: qcom-geni: Support multi-owner controllers in
 GPI mode
To: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        viken.dadhaniya@oss.qualcomm.com, andi.shyti@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        vkoul@kernel.org, Frank.Li@kernel.org, andersson@kernel.org,
        konradybcio@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
        linmq006@gmail.com, quic_jseerapu@quicinc.com, zhengxingda@iscas.ac.cn,
        kees@kernel.org, agross@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Cc: krzysztof.kozlowski@oss.qualcomm.com, bartosz.golaszewski@oss.qualcomm.com,
        bjorn.andersson@oss.qualcomm.com
References: <20260708051023.2872304-1-mukesh.savaliya@oss.qualcomm.com>
 <20260708051023.2872304-5-mukesh.savaliya@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260708051023.2872304-5-mukesh.savaliya@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Q63iJY2a c=1 sm=1 tr=0 ts=6a577bf4 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=Y68E4KffrGY8xuMxYjUA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: wmfpTtpDm6T4ABVjLJfvqRSxu3nRUVOf
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDEyMyBTYWx0ZWRfXypVCHq7G9dUc
 EFNQey1xsAQySKjdu4F5wQmODa/QM6qHLF1KIcRigWTjtjAG3jDOPKnv0SCh99vLgYrrV/xZH47
 /uJJny0iCZ24T8CeNG/ctA7nNJiKu/8=
X-Proofpoint-GUID: wmfpTtpDm6T4ABVjLJfvqRSxu3nRUVOf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDEyMyBTYWx0ZWRfX4rVY9CdhLO+Y
 xS/P1j7BFY/bMvvXukOj4aUldslBhzHVdHaQPxu/020gchL/jnVok6bOKZiw5IZMtv05cnHzwPQ
 o7ZsYS7XPp6InTu67d4A+N9QQ2nGvcCKccLoyVxLne2WKIpMkh38SsGiXLFnXiz4NN3WVKejipb
 YcDkwK9LpCGWFS8hSxiH+jza8Wn8tO0lmYPTY0dMPr5BWpkV/ClvMp2JKhX8QYNWlaIug6qc0Yp
 Nj2uMrOvvAcXx9oQ29Bj2vBw1woYVGa3e0cWTX6gYBsjgwDY+uXsW6FdiHab/rRHjVlythxpFse
 uWgZml+8qdAqfNXpsH2JkYk53hLtwwX04GRC4MKLt5GYeSmnLnqtS6vNg7xPACypcHnuK7tzCEZ
 Z2Ta1lif0qbPKer3XE9hpS/pAKWTZQ3PhjIElqHQWVpGLdmouhXporNlMaxHHNvudXdrjTLqYQU
 p9z4JAzjjOHbmMYkEsg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0
 phishscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150123
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12551-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mukesh.savaliya@oss.qualcomm.com,m:viken.dadhaniya@oss.qualcomm.com,m:andi.shyti@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:dmitry.baryshkov@oss.qualcomm.com,m:linmq006@gmail.com,m:quic_jseerapu@quicinc.com,m:zhengxingda@iscas.ac.cn,m:kees@kernel.org,m:agross@kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-i2c@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dmaengine@vger.kernel.org,m:krzysztof.kozlowski@oss.qualcomm.com,m:bartosz.golaszewski@oss.qualcomm.com,m:bjorn.andersson@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,gmail.com,quicinc.com,iscas.ac.cn,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[24];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[konrad.dybcio@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2600:3c0a:e001:db::12fc:5321:from];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DNSWL_BLOCKED(0.00)[209.85.222.198:received,100.90.174.1:received,205.220.180.131:received,2600:3c0a:e001:db::12fc:5321:from,178.235.128.140:received];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RECEIVED_SPAMHAUS_PBL(0.00)[178.235.128.140:received];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.90.174.1:received,209.85.222.198:received];
	DWL_DNSWL_BLOCKED(0.00)[qualcomm.com:dkim];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 430BC75E1DC
X-Rspamd-Action: no action

On 7/8/26 7:10 AM, Mukesh Kumar Savaliya wrote:
> Some platforms use a QUP-based I2C controller in a configuration where the
> controller is shared with another system processor. In this setup the
> operating system must not assume exclusive ownership of the controller or
> its associated pins.
> 
> Add support for enabling multi-owner operation when DeviceTree specifies
> qcom,qup-multi-owner. When enabled, mark the underlying serial engine as
> shared so the common GENI resource handling avoids selecting the "sleep"
> pinctrl state, which could disrupt transfers initiated by the other
> processor.
> 
> For GPI mode transfers, request lock/unlock TRE sequencing from the GPI
> driver by setting a single lock_action selector per message, emitting lock
> before the first message and unlock after the last message (handling the
> single-message case as well). This serializes access to the shared
> controller without requiring message-position flags to be passed into the
> DMA engine layer.
> 
> Signed-off-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
> ---

[...]


> +		if (gi2c->se.multi_owner)
> +			return dev_err_probe(gi2c->se.dev, -EINVAL,
> +					     "I2C sharing not supported in non GSI mode\n");

ultra nit: "non-GSI"

> +
>  		tx_depth = geni_se_get_tx_fifo_depth(&gi2c->se);
>  
>  		/* I2C Master Hub Serial Elements doesn't have the HW_PARAM_0 register */
> @@ -1098,6 +1115,11 @@ static int geni_i2c_probe(struct platform_device *pdev)
>  		gi2c->clk_freq_out = I2C_MAX_STANDARD_MODE_FREQ;
>  	}
>  
> +	if (of_property_read_bool(pdev->dev.of_node, "qcom,qup-multi-owner")) {

Let's use device_property_present() instead.

with that:

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

