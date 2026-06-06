Return-Path: <dmaengine+bounces-11263-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2ATBJaMWJGqz2wEAu9opvQ
	(envelope-from <dmaengine+bounces-11263-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 14:46:27 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB18A64D80E
	for <lists+dmaengine@lfdr.de>; Sat, 06 Jun 2026 14:46:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=LIgNCPTK;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=TZjfWCs3;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11263-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11263-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CBA7305BF96
	for <lists+dmaengine@lfdr.de>; Sat,  6 Jun 2026 12:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32C53ACA42;
	Sat,  6 Jun 2026 12:41:24 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7883ABDA8
	for <dmaengine@vger.kernel.org>; Sat,  6 Jun 2026 12:41:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780749684; cv=none; b=vBmK3rRZhirbrp213eBr2txhcyi1MetAEc+eAHZzJQctPJ7Slj5NQyOi8jZizozctMm67KxY5MJ9wEmOXXLi8GNQIh3+TiTL89auP80Jy24lzWAMOtcCkgtwcCf3z4ygLodP9ypc6SIeA8pk6usXXT8S+6Vot45pTlvx0QK8xFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780749684; c=relaxed/simple;
	bh=6uToLWIkhMVLVPs5bVfaOcvpcrTZrOqNSF1Bm7annfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uq8+0BM+AkIYg1gqBP/dUQ7If7E/cjCnbBmRaQ4LJ9YPdyZsacJnn66KUq/QfPkm6+4t2fkveM0QV3hswvV7wQiszzbeH8BF0jOtiRCOCtj6JvpNFINKxJD5Z4GaqE475+CKO/gaqOZE+CvXTHkdyF19uP5ONSx7W8EVEKWCGF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LIgNCPTK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TZjfWCs3; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 656BEg8V1258963
	for <dmaengine@vger.kernel.org>; Sat, 6 Jun 2026 12:41:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ojRmqHVzAY9ubyxt9hMVCKPiSD0rZfJdWLUlBw5lSJc=; b=LIgNCPTKnlPTSgSb
	CvI34d80M5q9qq/2h9651kVdt5wnHzR0rDNvy6DnetFDXQY8eWXBEJVsHt/BgnET
	5jy5zUbvK0UlubLyrsTpfYvfBei4XD+mU84+FPBBYqi+KDo67EW95nDUjjd3NkMY
	Kx3LzU93ncEVqWcOQXiUmKZNYrlpzKVIfoJMFwDyFWf6BU4K4la5IlrPgeQciobN
	K9GW+Rlelrixv4iUWkyrHp/JHtqCNIgMoNOFRY9W9Vddzer3gr7xUJ77tmRMlWyz
	Hsblm+NLYR+NKitIMVBmQED37LGtcOEcP5mH9V5Kiss3JvPikr68MhrPjyZG51rH
	/anPgQ==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emcadrvmv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Sat, 06 Jun 2026 12:41:22 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5ab02fb3054so1996274e0c.0
        for <dmaengine@vger.kernel.org>; Sat, 06 Jun 2026 05:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780749682; x=1781354482; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ojRmqHVzAY9ubyxt9hMVCKPiSD0rZfJdWLUlBw5lSJc=;
        b=TZjfWCs3taNBpam4vBTQoYmIK7d4q9QK2pIgl4/ccaFdxsGzr/L94NBTQj7S+R4/aH
         2XL4P17mYXMR03qpXrd5Hxt0KDs7kHMP4ao5m9+SUqEOwCU69G7F4XnDHxjeR5qDKp+6
         uVKx9IPT28eo04HlT7x5bfSyksF+LSqUsDkx+rv6AonwH6EOKx/LAyqszfOVYFI2tjO5
         vi3kE5hgpSf7/kMP0QJgXsA6qr/IBtXJLWkFHMItuoYX/Jr3kFEBsFpUGAKsbuUwliPV
         j/mcv0llWVy1YJWPTdSSwU7t/ZDx3AiEcgwy5uvSogbL333cITk+2M9GYILPkBYFRVlV
         +CYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780749682; x=1781354482;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ojRmqHVzAY9ubyxt9hMVCKPiSD0rZfJdWLUlBw5lSJc=;
        b=S8iv6lPagSZMjaKEHnV2hY9Jl54kUgGyfodi16BpLhNkIhaLwuGjj063Sm77D588JG
         3+zqGp81SuKiECFUEms/NCZtVpc88yo0RY4f4ASK7y70KmVmG6y7+MgR+GhHSzA/X50M
         tp1zpEs7ZNuXynpkRb+hUVfLRYweqhxeR43y0L7AEQGSQ74o5acPwoe6fbRY1qJWC89+
         mmmiLJttUisnySzPBHLEWZH5ythV4iiJXdxERNTjpkYwLbWKUUb65UsAwmJB3oN68pt4
         8T5ssz6oQbrdoafAgBEdJOR/v8BuomrJ9ORbdpYCrkL6/ulNCJH0EujUOJdxJTLHX/+u
         8smQ==
X-Forwarded-Encrypted: i=1; AFNElJ/7Iw/7kWiQrVysWmjCoH8ZNWThoY2EfDlvenol/8TMjrKbhaVtcksfRBSRovAapZDLgvix//oWE98=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1lYP1EGsdegJL4KsdYUHp5BmCuPCKX2nn1RprK1c08A90ewQM
	jg++4UP5/q/0Bh3MJ7PYmJjXq02KmIP8X5SqdlbiDF9O6G8+5TSJhMFniFgxtJ1AwFQ+OHkepgk
	dol3iS8PacrPu6vwVDqIusRi0EmCu2RmhWgcCnXwMn14r/eLOqBRf8Hl/41TiWtA=
X-Gm-Gg: Acq92OEFcED12QT8oVwL2ODClZnGcnpi1bqeVr/muPxVKf4h1S9mFKF93pWzgTXcJx1
	jDEtFeOiBAeZvJf6OhhBVM18hHiFkwoZiGkuXFpvjys9rOUMqjw6WarcexI+oe4dcsNv8q6pkld
	0oujcgwBTe0927zPxVlMpVJhxedqli5Bil9Er8eCECK112FMhFTOc2WI2SdAxN+Ivp4mztGlDoS
	9ZO2TkmHlwjaK5mhUyNZQ4P/QUzYW/TQ1Xn8V2woxcYpvm+ZfBbSueVDasUxYrUXlRyeEu08udL
	Rww4FiZhnMbkemJ8UD1vhwelyKs866CcNBlNooBzdFlXzjM/WijO5OIRh3VkOUkurSzWBxNVzLx
	778hp3TbZaKibmWMWT7UJymJbX0tpWqmpE4uJ7Ac3Q3A4LaqL8SDcQcFH2fDygB4XVu1kX1Dnav
	TCPl7xY/KHaYdwZyyVRCrJ/2P9LeuzhFPmN1wctvzieoWYYQ==
X-Received: by 2002:a05:6102:3ec8:b0:6e7:5c89:3fb3 with SMTP id ada2fe7eead31-6feef48d3b0mr3910655137.3.1780749681749;
        Sat, 06 Jun 2026 05:41:21 -0700 (PDT)
X-Received: by 2002:a05:6102:3ec8:b0:6e7:5c89:3fb3 with SMTP id ada2fe7eead31-6feef48d3b0mr3910636137.3.1780749681305;
        Sat, 06 Jun 2026 05:41:21 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b8ed74asm2416158e87.13.2026.06.06.05.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 05:41:20 -0700 (PDT)
Date: Sat, 6 Jun 2026 15:41:18 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Subject: Re: [PATCH v3 09/10] arm64: dts: qcom: shikra: Enable TSENS and
 thermal zones
Message-ID: <nescd2gwgx6msrzsawljoktwaxtmyo4xdi5s4csy2na6pebcsy@ldzwnj6fxl7c>
References: <20260601-shikra-dt-m1-v3-0-0fe3f8d9ec48@oss.qualcomm.com>
 <20260601-shikra-dt-m1-v3-9-0fe3f8d9ec48@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260601-shikra-dt-m1-v3-9-0fe3f8d9ec48@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=DIa/JSNb c=1 sm=1 tr=0 ts=6a241572 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=6o-Bo2YM3VKyGZF6QcIA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-GUID: WEJsevnOVdB_V0Y-yQoVHmO6y0p8jPeR
X-Proofpoint-ORIG-GUID: WEJsevnOVdB_V0Y-yQoVHmO6y0p8jPeR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA2MDEyNyBTYWx0ZWRfX9kpRJUZ1zvTW
 uqqfwEXG7vD9D+HM4GfUhcPLM2HG2aZx+MIQtDgIlnWOHIPFiFRyREjjpXvxzA7DbDBouEMlgsk
 Wr7u32irm3afmGZj9oMKiMVIhWaeyY0TebTKJ4M5P6s5ZYgd+9RXbAdYCXry130dvX9uWYKa/YP
 KkBsX4U9q7Z9Z707D1MZ50HG/HtnqsjYjEgjf43SC5mZ0WgDpmdSfL+6kTQE8+YGD28oX2iiGsP
 J+RYN9KJuCos7rEbjGjUbW4yr83gZBYpoFw8S5BIaxi+mk+K6WNEMYhpWn8OYD4CnKg6i4BsRLO
 lN+jVmR2Olnwy7j58oL/csYKPG87DQ3puH0KaLYcgeSAKPy50xXRNHFdkAwQZGBqPTqMA4GM/qT
 ILYnbSSkABGpJu1eUPipGjno5O5DTMk95TFS6wMlK0oNvZ0jU2lhnvc20VVywVLLJNNzTuu4pRB
 4HGQzAvwSkp9YARjOYg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-06_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606060127
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11263-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,vger.kernel.org:from_smtp,qualcomm.com:email,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ldzwnj6fxl7c:mid];
	FORGED_SENDER(0.00)[dmitry.baryshkov@oss.qualcomm.com,dmaengine@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS(0.00)[m:komal.bajaj@oss.qualcomm.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:krzk@kernel.org,m:djakov@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:linux-arm-msm@vger.kernel.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pm@vger.kernel.org,m:gaurav.kohli@oss.qualcomm.com,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CB18A64D80E

On Mon, Jun 01, 2026 at 06:25:11PM +0530, Komal Bajaj wrote:
> From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> 
> The shikra includes one TSENS instance, with a total of 14 thermal
> sensors distributed across various locations on the SoC.
> 
> The TSENS max/reset threshold is configured to 120°C in the hardware.
> Enable all TSENS instances, and define the thermal zones with a hot trip
> at 110°C and critical trip at 115°C.
> 
> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/shikra.dtsi | 267 +++++++++++++++++++++++++++++++++++
>  1 file changed, 267 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

