Return-Path: <dmaengine+bounces-11294-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3tZmHMN+JmrWXQIAu9opvQ
	(envelope-from <dmaengine+bounces-11294-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 10:35:15 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAB56541C6
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 10:35:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=E6lLaA8q;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=dcIp1Ups;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11294-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11294-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6BFB0303FBB3
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jun 2026 08:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A483AEB4E;
	Mon,  8 Jun 2026 08:22:44 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054143ACF10
	for <dmaengine@vger.kernel.org>; Mon,  8 Jun 2026 08:22:39 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780906963; cv=pass; b=pjhvqoz+p6vIzuCDBjcyU2WmXlRV9F7GaNIXAduKnxzhm2EWTuIy4C6rgOqHG5IpJ4DGK6aYdRl9nWKjCP3BP0d49DFh0V8qqb6hocilO3boGYr+flCFAKgVz4AS4hZlJtLJJY0NB3Aket/hz1hjwkMf+ihUn93YvutEPiM14/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780906963; c=relaxed/simple;
	bh=vtWNS3npdkcAslK/SBBMO1SRfQSABiKbV8HThujbXD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JF1rjI2f8O7qrnGHJ7g20JuBsoeoCNPyy2TpsiGui5ZqhjXl3Ap7nBv8/30ndzjV9iE182gy5nRfisEzyTUe4D1OM9dHV+mCKWyPIVTgahLzu7HnLo5Rd0MqEyDsv8MlUVvfE5M5C0khnvs3zOx8sAnfStiYDFI0i/XZZKxss2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E6lLaA8q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dcIp1Ups; arc=pass smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6586Or072274512
	for <dmaengine@vger.kernel.org>; Mon, 8 Jun 2026 08:22:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9wGRM2G7GFOfRieqrdglkkypXPcFdrC7Gmylel9Y3go=; b=E6lLaA8qN09yGM+s
	c+LUGNc/oB5k0DXe8dZ6ZZsQPGDMTMob4DRZoWJLiZdUObBzjZgJJgQeoL/XVOgm
	OSH6M5XIugSvBr16h3HG6vCUKQGG8DY6Trjf0knwsA+CN8DIxSrVu1eEplln7Mj+
	C56Fu2DvVxiV0A9U5GcQsroffiLpMkXjmY1xD/zAveUgBW+fVu5KX+0OgaAab8gw
	8SR6n69zkCoWI+E3ZZ6IV88maTxranZUJUvTDn0AWSoY4Wi5lLu85j/ijRJWCJKg
	RsIm4M7+yLDQxv/+4fy6Hbm+XPBQPN0WVWKXr6RnVqfOHFrtGaWKrz+8DwpE/zQ3
	/XNh2w==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emcqgxfuy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 08 Jun 2026 08:22:39 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-915b6b63056so490267185a.1
        for <dmaengine@vger.kernel.org>; Mon, 08 Jun 2026 01:22:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780906958; cv=none;
        d=google.com; s=arc-20240605;
        b=OlO+ykrJ2S3QjcuB8UbFLspUnfgZLpTngtyOTMY/7cqnygIFQgQY76RfpCWtKbdNCo
         V5riJso4MDvwAAwBCqhSLcyoqcenFudp7vpKgHc6XAPygLBIyO4BfFeyRDfy85m52KVs
         OjEg1OtBlCMUWaO4anyzdOft2ytwwODDYh5NtTI0G/6cusb6jkAV2Uq+/GVnp7Km9Zdr
         /BkH95JpW4UhupErR7YjfdFayWiN24p4Ifdfg5Z4Y5fOXdIsmHd731pYwmUFDQE9wSmk
         Hr97HTEKvqsA423UY/ewQ5l6wsTClgxvDH0uLyaR6udJfeLeIbw1uNuBZaOJ01SRGF1A
         nboA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9wGRM2G7GFOfRieqrdglkkypXPcFdrC7Gmylel9Y3go=;
        fh=kJRcIrYm1OiEoWJTqRWvuAvq89b+GaGnp8QMGs0vRWY=;
        b=YE/lmS3maHLWJ3H9I2DEl4FU7Gqo6KIIIq6ETxYwOIDzH5VwJMXn6rVQHCpg87PQ0K
         gfwSdfp+/AJC8+xhALfVQjATWc/00agkfNhRMVpezHEhjsoWDPNM1Vv/NBpS2IaRsbzF
         dZxdFywp5eKglciPZlVX4TYv2M4svunp1doM/3ce3fnngoxmzYhIvL+Ejb3N0rbMp2kK
         ZBi3CN1xx23iOLvf5OZOCshaS8T8C8N58qo2ji0mE/cXRkaalnbPZBavv+CgpIcsPjaU
         q9Ky6i10CUWCaPn0MkdlUotuelgOS6B8CpXauCFUY8IZMHZfHSWPmKzEor2XjAjReuIs
         IGoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780906958; x=1781511758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9wGRM2G7GFOfRieqrdglkkypXPcFdrC7Gmylel9Y3go=;
        b=dcIp1UpsVcwo2HBMwV6XcwuN1/QDxFNzp+kZq8LIS1YNTAAWIiMA/NoM3sfzCJyYXG
         cJOOJumMMHX5nEsY03btyD23HgeYl3tbN7YomVCkwnzeeYi1Pv8fzH6fAdxoUQzs/aVL
         oEfyHj1WfPR7LZVf4QklFzPoiOZ97YwXxQJDl77n4WIuvOyWCQbGlyCwroDTaspfLTQN
         sURLhgNrffLs21I/v1/DnRZhKvhvz4yhJ6VIhwfIZloONlv+Fl1srQB2O8giNjPjHGmM
         muE75yhkfvim/VOWZXMF7OHoNaiux5eBOofswmlXJiinYUZBJZBG6GtY+jKoju71sass
         GT0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780906958; x=1781511758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9wGRM2G7GFOfRieqrdglkkypXPcFdrC7Gmylel9Y3go=;
        b=MqxvfJe6nGONSBjUMwtbKO9/B+rSrXfK9yj3d1sD8HhlnkMr6dEH8YFmwHZWGWhu/U
         FjMszPJ22sDyXvLEgxd1UVo73uru0nR+pMvHD6WfFp/Rjc+kHt/l0DmtMFZDcxQEaSpm
         RJh5hMRAFWUr520TzIYNp24EKhOSR5fqus4mjaTHZDqCFOGxNuo4X1Bz1ozEHidTTL66
         cCSl/KI7AKwSbJPcBI4PZdC2RqKc6hl9ZxuR24Iq3txf0JODWON3bs9a+jKG0ARZSA87
         bRViJGCVq7+ikr7Kt0AWfp5kB43CN9JQFOSn1BADXN2r3i1w4YV9icRyCKzfl93OQ1Jg
         8/uQ==
X-Forwarded-Encrypted: i=1; AFNElJ/rE5+DteD6rVtCqZ59fnjk5+7nGQDOkvqMqqi17WVd/qM3XQBl22X1lV4fJ/IBlOKLSHyk2RtlktY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHTkO5Pb0hYUbB0/H8+rp3DOxJHigeXYWMZJxJQYZVfbwulDaH
	dku9R/1g00exfP9KYOKv7PQRsKPUeQwVanX7+0GY4BeaXksKI72/XXpAhVYgznX2jlOCjY0A2wO
	55Iiyd9/GEgfkYYLawybG0BD6mNL0f4ZHdEHUaM9CukCJ5U/2Z5fBHimUOPc+lmOAz7XIaAbosY
	H+TVwFwfHQC6Tf7P6+7N4Sv6knqV+1Lz1giOmTDQ==
X-Gm-Gg: Acq92OFhA39YHCL9guMxAZwWHyvjh8jahYA3dQPgIO0CW5cgoXxBGRDaZAhn/2sg7Me
	jWkU1HeFBkjPKc8+j94At19y0Bj3l4v0YrF2nLpfbbVhfwk9cTF5ch+GQep56bq4182u1RNcGvc
	0Rj2vTH+jr6KQGII3il/98z5ipe21JJWiMSJLet0pyHBzZxpOs99e3nj2W0MatZfjcCa9VFsnNX
	VA2YAgbtcCI3n52UVnWnBxqJ2461UWiuPuI5plh7uPKsyGRXG5k0rmc/9pKzTHHY5QunVZnYWDo
	hjWuzpq166bHBPz7LfeNww+RVwMM+kbcxfqm5+Td/9ifpXo2wjbPIsN0GUw+
X-Received: by 2002:a05:620a:f0d:b0:915:931e:5e8c with SMTP id af79cd13be357-915a9c7584dmr2385827185a.7.1780906958033;
        Mon, 08 Jun 2026 01:22:38 -0700 (PDT)
X-Received: by 2002:a05:620a:f0d:b0:915:931e:5e8c with SMTP id
 af79cd13be357-915a9c7584dmr2385823485a.7.1780906957558; Mon, 08 Jun 2026
 01:22:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601-shikra-dt-m1-v3-0-0fe3f8d9ec48@oss.qualcomm.com>
 <20260601-shikra-dt-m1-v3-10-0fe3f8d9ec48@oss.qualcomm.com>
 <CAFEp6-2rT5fXkWaa-Fd--h8zuJ7kQqPyjedGNXrGvco79yMJCg@mail.gmail.com> <2f963239-e1f3-4966-b442-7d44f372ea3d@oss.qualcomm.com>
In-Reply-To: <2f963239-e1f3-4966-b442-7d44f372ea3d@oss.qualcomm.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 10:22:25 +0200
X-Gm-Features: AVVi8CfaqXeEW7_fGzZ87WHqiQ-n3gAVt2qJ12GlDUzulGzVwqZJCRnMLkCi62M
Message-ID: <CAFEp6-0xpsNHn-Dg9LKLvMbnPD6DBo6fi5iEo6DWR8uosVxQfw@mail.gmail.com>
Subject: Re: [PATCH v3 10/10] arm64: dts: qcom: shikra: Enable Bluetooth and
 WiFi on EVK boards
To: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Cc: Komal Bajaj <komal.bajaj@oss.qualcomm.com>, Vinod Koul <vkoul@kernel.org>,
        Frank Li <Frank.Li@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=dJGWXuZb c=1 sm=1 tr=0 ts=6a267bcf cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=gccCA3bCN5zK5WmTdcQA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: pz-mwytMIy2_QWTb8bcKruNzszzPCCjn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA3NiBTYWx0ZWRfX/aaOmA9M37u5
 QSVzySijf99VJiyEaj+q2cE8zwzq6TDMPnLFl19ZfA+C9y4QWcCoT09qF64AwOQbcMMY/OD2l4f
 mKch0QtywH8GMxxjrQWutZxCO4QQXiwWP3cZ9SlbS+sUpSMDyEsYab7hHtkq5imZB6pdx4e/Ak3
 chwMZjUlHfYrB+6leq1nIi3q5bir82lLsQDrO7JEbPJbiatNDLh/W1a7iLeEdR4KWhYJnW2o6jC
 jC6BgtHURceH+LSPBXjLJmh7djlsFRGO1o1IcL5+tVcjWPSuKBha/ryC+HWctjVzM8Pe9U2pNHG
 g638RiX/5Ti36YXqwZm4zSw7m5Tex15KZ9BjqTf2jCkoXyymeOniPQajqlNjumPzk7YgKkbmjYX
 RoyxKC7CpcevNJsrFRQ4e5FnHiDUE4pCiDU7VyKsF5yj9nvuzwsqr47iQEywsp2kuKNH0DOUWGk
 9iFmRf3zIA2G2i4ihYA==
X-Proofpoint-ORIG-GUID: pz-mwytMIy2_QWTb8bcKruNzszzPCCjn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080076
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11294-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:miaoqing.pan@oss.qualcomm.com,m:komal.bajaj@oss.qualcomm.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:krzk@kernel.org,m:djakov@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:linux-arm-msm@vger.kernel.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pm@vger.kernel.org,m:yepuri.siddu@oss.qualcomm.com,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[loic.poulain@oss.qualcomm.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loic.poulain@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EDAB56541C6

On Mon, Jun 8, 2026 at 4:26=E2=80=AFAM Miaoqing Pan
<miaoqing.pan@oss.qualcomm.com> wrote:
>
>
>
> On 6/6/2026 8:57 PM, Loic Poulain wrote:
> > On Mon, Jun 1, 2026 at 2:57=E2=80=AFPM Komal Bajaj <komal.bajaj@oss.qua=
lcomm.com> wrote:
> >> Enable Bluetooth and WiFi connectivity on Shikra CQM, CQS and IQS
> >> EVK boards using the WCN3988 combo chip.
> >>
> >> For Bluetooth, enable uart8 and add WCN3988 Bluetooth node with
> >> board-specific regulator supplies across CQM, CQS and IQS Shikra
> >> EVK boards.
> >>
> >> For WiFi, introduce the wcn3990-wifi hardware node in shikra.dtsi
> >> with register space, interrupts, IOMMU configuration and reserved
> >> memory. The node is kept disabled by default and enabled per-board
> >> with the appropriate PMIC supply connections and calibration variant
> >> selection.
> >>
> >> Co-developed-by: Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
> >> Signed-off-by: Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
> >> Co-developed-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
> >> Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
> >> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> >> ---
> >>   arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts | 59 +++++++++++++++++++=
++++++
> >>   arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts | 59 +++++++++++++++++++=
++++++
> >>   arch/arm64/boot/dts/qcom/shikra-evk.dtsi    | 15 +++++++
> >>   arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts | 67 +++++++++++++++++++=
++++++++++
> >>   arch/arm64/boot/dts/qcom/shikra.dtsi        | 23 ++++++++++
> >>   5 files changed, 223 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts b/arch/arm64/=
boot/dts/qcom/shikra-cqm-evk.dts
> >> index b112b21b1d79..c2ed0396533a 100644
> >> --- a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
> >> +++ b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
> >> @@ -16,11 +16,48 @@ / {
> >>          aliases {
> >>                  mmc0 =3D &sdhc_1;
> >>                  serial0 =3D &uart0;
> >> +               serial1 =3D &uart8;
> >>          };
> >>
> >>          chosen {
> >>                  stdout-path =3D "serial0:115200n8";
> >>          };
> >> +
> >> +       wcn3988-pmu {
> >> +               compatible =3D "qcom,wcn3988-pmu";
> >> +
> >> +               pinctrl-0 =3D <&sw_ctrl_default>;
> >> +               pinctrl-names =3D "default";
> >> +
> >> +               vddio-supply =3D <&pm4125_l7>;
> >> +               vddxo-supply =3D <&pm4125_l13>;
> >> +               vddrf-supply =3D <&pm4125_l10>;
> >> +               vddch0-supply =3D <&pm4125_l22>;
> >> +
> >> +               swctrl-gpios =3D <&tlmm 88 GPIO_ACTIVE_HIGH>;
> >> +
> >> +               regulators {
> >> +                       vreg_pmu_io: ldo0 {
> >> +                               regulator-name =3D "vreg_pmu_io";
> >> +                       };
> >> +
> >> +                       vreg_pmu_xo: ldo1 {
> >> +                               regulator-name =3D "vreg_pmu_xo";
> >> +                       };
> >> +
> >> +                       vreg_pmu_rf: ldo2 {
> >> +                               regulator-name =3D "vreg_pmu_rf";
> >> +                       };
> >> +
> >> +                       vreg_pmu_ch0: ldo3 {
> >> +                               regulator-name =3D "vreg_pmu_ch0";
> >> +                       };
> >> +
> >> +                       vreg_pmu_ch1: ldo4 {
> >> +                               regulator-name =3D "vreg_pmu_ch1";
> >> +                       };
> >> +               };
> >> +       };
> >>   };
> >>
> >>   &remoteproc_cdsp {
> >> @@ -57,3 +94,25 @@ &sdhc_1 {
> >>
> >>          status =3D "okay";
> >>   };
> >> +
> >> +&uart8 {
> >> +       status =3D "okay";
> >> +
> >> +       bluetooth {
> >> +               vddio-supply =3D <&vreg_pmu_io>;
> >> +               vddxo-supply =3D <&vreg_pmu_xo>;
> >> +               vddrf-supply =3D <&vreg_pmu_rf>;
> >> +               vddch0-supply =3D <&vreg_pmu_ch0>;
> >> +       };
> >> +};
> >> +
> >> +&wifi {
> >> +       vdd-0.8-cx-mx-supply =3D <&pm4125_l7>;
> >> +       vdd-1.8-xo-supply =3D <&vreg_pmu_xo>;
> >> +       vdd-1.3-rfa-supply =3D <&vreg_pmu_rf>;
> >> +       vdd-3.3-ch0-supply =3D <&vreg_pmu_ch0>;
> >> +       qcom,calibration-variant =3D "Shikra_EVK";
> >> +       firmware-name =3D "cq2390";
> >> +
> >> +       status =3D "okay";
> >> +};
> >> diff --git a/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts b/arch/arm64/=
boot/dts/qcom/shikra-cqs-evk.dts
> >> index e62ba5aef71f..3bfd0050064f 100644
> >> --- a/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
> >> +++ b/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
> >> @@ -16,11 +16,48 @@ / {
> >>          aliases {
> >>                  mmc0 =3D &sdhc_1;
> >>                  serial0 =3D &uart0;
> >> +               serial1 =3D &uart8;
> >>          };
> >>
> >>          chosen {
> >>                  stdout-path =3D "serial0:115200n8";
> >>          };
> >> +
> >> +       wcn3988-pmu {
> >> +               compatible =3D "qcom,wcn3988-pmu";
> >> +
> >> +               pinctrl-0 =3D <&sw_ctrl_default>;
> >> +               pinctrl-names =3D "default";
> >> +
> >> +               vddio-supply =3D <&pm4125_l7>;
> >> +               vddxo-supply =3D <&pm4125_l13>;
> >> +               vddrf-supply =3D <&pm4125_l10>;
> >> +               vddch0-supply =3D <&pm4125_l22>;
> >> +
> >> +               swctrl-gpios =3D <&tlmm 88 GPIO_ACTIVE_HIGH>;
> >> +
> >> +               regulators {
> >> +                       vreg_pmu_io: ldo0 {
> >> +                               regulator-name =3D "vreg_pmu_io";
> >> +                       };
> >> +
> >> +                       vreg_pmu_xo: ldo1 {
> >> +                               regulator-name =3D "vreg_pmu_xo";
> >> +                       };
> >> +
> >> +                       vreg_pmu_rf: ldo2 {
> >> +                               regulator-name =3D "vreg_pmu_rf";
> >> +                       };
> >> +
> >> +                       vreg_pmu_ch0: ldo3 {
> >> +                               regulator-name =3D "vreg_pmu_ch0";
> >> +                       };
> >> +
> >> +                       vreg_pmu_ch1: ldo4 {
> >> +                               regulator-name =3D "vreg_pmu_ch1";
> >> +                       };
> >> +               };
> >> +       };
> >>   };
> >>
> >>   &remoteproc_cdsp {
> >> @@ -57,3 +94,25 @@ &sdhc_1 {
> >>
> >>          status =3D "okay";
> >>   };
> >> +
> >> +&uart8 {
> >> +       status =3D "okay";
> >> +
> >> +       bluetooth {
> >> +               vddio-supply =3D <&vreg_pmu_io>;
> >> +               vddxo-supply =3D <&vreg_pmu_xo>;
> >> +               vddrf-supply =3D <&vreg_pmu_rf>;
> >> +               vddch0-supply =3D <&vreg_pmu_ch0>;
> >> +       };
> >> +};
> >> +
> >> +&wifi {
> >> +       vdd-0.8-cx-mx-supply =3D <&pm4125_l7>;
> >> +       vdd-1.8-xo-supply =3D <&vreg_pmu_xo>;
> >> +       vdd-1.3-rfa-supply =3D <&vreg_pmu_rf>;
> >> +       vdd-3.3-ch0-supply =3D <&vreg_pmu_ch0>;
> >> +       qcom,calibration-variant =3D "Shikra_EVK";
> >> +       firmware-name =3D "cq2390";
> >> +
> >> +       status =3D "okay";
> >> +};
> >> diff --git a/arch/arm64/boot/dts/qcom/shikra-evk.dtsi b/arch/arm64/boo=
t/dts/qcom/shikra-evk.dtsi
> >> index 8b03d4eafa6d..a79f44aff968 100644
> >> --- a/arch/arm64/boot/dts/qcom/shikra-evk.dtsi
> >> +++ b/arch/arm64/boot/dts/qcom/shikra-evk.dtsi
> >> @@ -8,7 +8,22 @@ &qupv3_0 {
> >>          status =3D "okay";
> >>   };
> >>
> >> +&tlmm {
> >> +       sw_ctrl_default: sw-ctrl-default-state {
> >> +               pins =3D "gpio88";
> >> +               function =3D "gpio";
> >> +               bias-pull-down;
> >> +       };
> >> +};
> >> +
> >>   &uart0 {
> >>          status =3D "okay";
> >>   };
> >>
> >> +&uart8 {
> >> +       bluetooth {
> >> +               compatible =3D "qcom,wcn3988-bt";
> >> +               max-speed =3D <3200000>;
> >> +       };
> >> +};
> >> +
> >> diff --git a/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts b/arch/arm64/=
boot/dts/qcom/shikra-iqs-evk.dts
> >> index 727809430fd1..95bd797d009d 100644
> >> --- a/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
> >> +++ b/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
> >> @@ -16,11 +16,56 @@ / {
> >>          aliases {
> >>                  mmc0 =3D &sdhc_1;
> >>                  serial0 =3D &uart0;
> >> +               serial1 =3D &uart8;
> >>          };
> >>
> >>          chosen {
> >>                  stdout-path =3D "serial0:115200n8";
> >>          };
> >> +
> >> +       vreg_wcn_3p3: regulator-wcn-3p3 {
> >> +               compatible =3D "regulator-fixed";
> >> +               regulator-name =3D "wcn_3p3";
> >> +               regulator-min-microvolt =3D <3300000>;
> >> +               regulator-max-microvolt =3D <3300000>;
> >> +               regulator-always-on;
> >> +       };
> >> +
> >> +       wcn3988-pmu {
> >> +               compatible =3D "qcom,wcn3988-pmu";
> >> +
> >> +               pinctrl-0 =3D <&sw_ctrl_default>;
> >> +               pinctrl-names =3D "default";
> >> +
> >> +               vddio-supply =3D <&pm8150_s4>;
> >> +               vddxo-supply =3D <&pm8150_l12>;
> >> +               vddrf-supply =3D <&pm8150_l8>;
> >> +               vddch0-supply =3D <&vreg_wcn_3p3>;
> >> +
> >> +               swctrl-gpios =3D <&tlmm 88 GPIO_ACTIVE_HIGH>;
> >> +
> >> +               regulators {
> >> +                       vreg_pmu_io: ldo0 {
> >> +                               regulator-name =3D "vreg_pmu_io";
> >> +                       };
> >> +
> >> +                       vreg_pmu_xo: ldo1 {
> >> +                               regulator-name =3D "vreg_pmu_xo";
> >> +                       };
> >> +
> >> +                       vreg_pmu_rf: ldo2 {
> >> +                               regulator-name =3D "vreg_pmu_rf";
> >> +                       };
> >> +
> >> +                       vreg_pmu_ch0: ldo3 {
> >> +                               regulator-name =3D "vreg_pmu_ch0";
> >> +                       };
> >> +
> >> +                       vreg_pmu_ch1: ldo4 {
> >> +                               regulator-name =3D "vreg_pmu_ch1";
> >> +                       };
> >> +               };
> >> +       };
> >>   };
> >>
> >>   &remoteproc_cdsp {
> >> @@ -57,3 +102,25 @@ &sdhc_1 {
> >>
> >>          status =3D "okay";
> >>   };
> >> +
> >> +&uart8 {
> >> +       status =3D "okay";
> >> +
> >> +       bluetooth {
> >> +               vddio-supply =3D <&vreg_pmu_io>;
> >> +               vddxo-supply =3D <&vreg_pmu_xo>;
> >> +               vddrf-supply =3D <&vreg_pmu_rf>;
> >> +               vddch0-supply =3D <&vreg_pmu_ch0>;
> >> +       };
> >> +};
> >> +
> >> +&wifi {
> >> +       vdd-0.8-cx-mx-supply =3D <&pm8150_s4>;
> >> +       vdd-1.8-xo-supply =3D <&vreg_pmu_xo>;
> >> +       vdd-1.3-rfa-supply =3D <&vreg_pmu_rf>;
> >> +       vdd-3.3-ch0-supply =3D <&vreg_pmu_ch0>;
> >> +       qcom,calibration-variant =3D "Shikra_EVK";
> >> +       firmware-name =3D "cq2390";
> > Does the firmware differ from the one used on Agatti (QCM2290)?
> Yes, WCN3950 vs WCN3980.

It's not exactly my question, Agatti also supports both (e.g. WCN3988
is integrated to UNO-Q).

Regards,
Loic

