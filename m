Return-Path: <dmaengine+bounces-12122-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8xrkJHNyTmrTMwIAu9opvQ
	(envelope-from <dmaengine+bounces-12122-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 17:53:23 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5954D7284F4
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 17:53:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=povksdEE;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=NDt9Givq;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12122-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-12122-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B38C2301FFF0
	for <lists+dmaengine@lfdr.de>; Wed,  8 Jul 2026 15:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F60409278;
	Wed,  8 Jul 2026 15:53:18 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5B3406810
	for <dmaengine@vger.kernel.org>; Wed,  8 Jul 2026 15:53:16 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783525998; cv=pass; b=nLHQ4jTCyzi2qs9+qVfCD0DjN7iplD0PlxfaZsFCxn/5P6OMNIKE3nDeSl2xC/q6OAzwY6xSg62tFqes8HLMSzzfKUdDdfl2Q11b1CM341KgiPmexfbt0utbzOraqDvVxnpq7y/mbTTCr22+gCR+HvS/6CCw3pbn6iJbBE4uXDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783525998; c=relaxed/simple;
	bh=4fZLufBRbYv0ZeoDpC9ZF+sMAM/7XhJjxJD/9UyzC3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=USPGaL6wwaPTz76+3cjqnnYfeipQ/pEs0HUndn9CChmFYDToSRWUuQlLaJQ/U3hZ5LY40dhu5Hr698i1uKex8xMiyVVAjvkvzdLcWwCZsAaz15QxN7XmzpqLfhpoafaVtpKLxes30G2PgGPjKbn+MRqkvjbA+6ADwxj0VCPQ6GA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=povksdEE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NDt9Givq; arc=pass smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668C3DvF2751263
	for <dmaengine@vger.kernel.org>; Wed, 8 Jul 2026 15:53:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	euqtbZ8JKHVRTKJRjjj0PorQ8eQxhdkHP+XNgxpwhdw=; b=povksdEEU32r3U2F
	208oi4s1n1bP0yeqPcIppmU/CFq/z0p08+vUOGb1+bJfQopePrfbWPCi5pKmapfu
	xY5ZMZL+fhM+mHK636+iv6T2bySKiKVPwxvAafADP1rm0E9YF71ZlCObddX9+b7h
	eJ2ZLa89O4/eY1XXhqiLtPo3zpQQUrhecZ1u9YWOyFZncUKFGmH4wNDPyVYOcFWx
	C4TRD1jkgEth0B8iasVRKmeX2uUWUJw3TedN9oHHXd/jfF9gRTq6QBCYw9Rvfbya
	yN2GRoHefAatw7UHrkAFHJQ5+aqvsBJYfxPgWtc66NTUjrf/uYyO0qdv7XZbyuUl
	8jB6Eg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9g7hjjy7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Wed, 08 Jul 2026 15:53:16 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8eec6acbe21so21742386d6.3
        for <dmaengine@vger.kernel.org>; Wed, 08 Jul 2026 08:53:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783525995; cv=none;
        d=google.com; s=arc-20260327;
        b=ndWGTE5B8dxSRzxCD0h1u6LOHYh/ngB8jQdK/XZ+DRDOPOl0ls4cfCtntCwijfw/+x
         2RnPLI/E7x16bsB3bBV89Aw2TjENqyeER6tijxeRZtazCFy5oQvhfIkBRGT9XIaf0wmZ
         UF4aGKgoGyx17yYQAPK1HgyORfq6BVH2vR+1Vd5vM3+rm+TZDeJuiIzpXNQOUzzZANrW
         JrYgs9tjOKVIPbuV+UCkzlrn4CO+ZxEnCx7me8MirqBAsMVjxnkMYMIdpKRlQni1d23t
         4XVrP84zrLDAbSTg15hH2kfOejyMOm4hMIfkkUc+2r4tl79G5c16hqG5LQsFM94Istg8
         jixw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=euqtbZ8JKHVRTKJRjjj0PorQ8eQxhdkHP+XNgxpwhdw=;
        fh=7U/lC7U+vawtihzLhMIM3BzRmnSJcoHKuz/dzmJerpE=;
        b=eiIl74GNBPEXFk798v1k6OWpzDgReO3gdUooAkojVTc8l8HZ+bAMYRsWKSO0ma0pUd
         BwAMOG+0YG8D1CCfNl4aG6DDc6wt1Lofpytv/IC42k/bu4zHd5tfQnhkrfIDhk0tHZH6
         ghV/iD23pa48O44iS7Pib/xusUE3OREkq17NdqgOqsS8wn7ziHhxDS+D5yfCCfKmZfsV
         NGXp0evB8QmYSvRVF0C2p9nQSuYuKjsBqVgoeclfRM+iHon6at5dCOFdCe01hX4i+HKs
         x2H2K9lBzb7x4lqfkTSkiPmjdeTIUtZLzcN6GVslY4X6dYMIeQBKdokzvqAsHszEOhib
         No6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783525995; x=1784130795; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=euqtbZ8JKHVRTKJRjjj0PorQ8eQxhdkHP+XNgxpwhdw=;
        b=NDt9Givqru9KH49LUNTBx7QzaIDYfb3qEeX9kaDF10u9+HJpj62ndtvjczDL0P8gL4
         A+PGxJOgZkhyA5ISv8eurCsOgHbhHn6NG9DPrkUkSe8UKwDrL76WFSQCVyd/3A7Ds3Ht
         En0LC6IMiA/qm1dmNYkiqVUU/yqSuuU1XC006tOOnwukzx+pKGTk5LRH8w4H1NNdwNHq
         SR6nA8ql38aQx8HvFmNt7X+4MMuzDIOscnr8YHmjzImCTdJNc7hWSSHIYpxI0W7Faco6
         /F5dtU8EPbnNQeqotNXhUONIIIkkucpb53jS9xSSd9ozETg36QBS4EBHZNGaKVEQsfFP
         IDZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783525995; x=1784130795;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=euqtbZ8JKHVRTKJRjjj0PorQ8eQxhdkHP+XNgxpwhdw=;
        b=tJbAtv2GhblYjCwvm2izPvzz9vmU1crB3N7VGj0LCkGrbDtYunYpkZwENnGVLbGrz6
         jXtwB3VYifUjuaoQbecXCQrrYCthJIhJPHxq+zqKiKEfeeKzGWA53ov08CRTT/mnUm3J
         y61UXQaJp5C+/6P3H6UdXu1Lh0f9S3vhPFQeWpcrKSkkQHCqu49N1TSvATaqLvqFLjO1
         C70tqilhy5Gt+JStccU63u4vzT8D2JYeGdItACuUX6xcMelisIquLIsTfnKynZzcYx4m
         Nvj8NEpk1M0QgApiO2lZJB/gdwzGPeExKElgzxgSedSMiS0nwb30kOIiIhM7trGVGrB6
         EUfQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqnt2RMYDiaPTkiU67dEe+eUNwROtG6NGqJ7wlXkrMkiz4qAIHWvNTMXD+yAhsLvR7lpxmcTHNR0dk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc0ZSrwcOGXCr9OjKU19PFKSuA/x5M1X+eG74uH8K39TstbdXX
	NkXqVa0kQ7NqoUe1P+ScGgy47em8+Cs1YdxBHqhgJ/UGhe+JAq1vf3nYs0v/XDAzvnjUrtEHwxY
	1b1N+h8onlFS8PTuhs0Sejt8q4xc29T4ug5oQFpUQeQsyfQGIAIICXBRxDDN094TD2qZBEBjDfa
	+SvnWnkO+WjWu/oGWEjme2VPtlRbMzbkEz1qMYtA==
X-Gm-Gg: AfdE7ckei09QiSp2+FjGnlDEd0V46LxoudvtXhOrAGxEekI/qLHogi2zUjD+k/1BfPL
	NDuGdpHwOx/FBmvHBDvRzaLZOGXlL1Lqk9pH97Gm/0AX3fv2kH3xMbIgvq3Qfatc/k+zpH11XXa
	hDTb86pwBuZnCGjBuN618HAPZkCpySRqRZ+j/7GDl7D2xDM/Xlxhicwev1mJHxlvuHvxSj
X-Received: by 2002:a05:6214:5508:b0:8f1:323a:fc54 with SMTP id 6a1803df08f44-8fec361ce5fmr26792396d6.42.1783525994298;
        Wed, 08 Jul 2026 08:53:14 -0700 (PDT)
X-Received: by 2002:a05:6214:5508:b0:8f1:323a:fc54 with SMTP id
 6a1803df08f44-8fec361ce5fmr26792106d6.42.1783525993919; Wed, 08 Jul 2026
 08:53:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618-ux500-power-domains-v7-1-v1-0-eb5e50b1a588@kernel.org> <20260618-ux500-power-domains-v7-1-v1-10-eb5e50b1a588@kernel.org>
In-Reply-To: <20260618-ux500-power-domains-v7-1-v1-10-eb5e50b1a588@kernel.org>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 8 Jul 2026 17:53:01 +0200
X-Gm-Features: AVVi8Cfl9mmuZ0-N0YzXyQTku0PxVhLh9qj1SZFF_tsUR-VGJVPz8z3CnsVKBnw
Message-ID: <CAPx+jO-ow2vo2wMxERLGse88wLoaR=HLdOWk6Qwv97ZdbE4R5Q@mail.gmail.com>
Subject: Re: [PATCH 10/11] regulator: db8500: Add power domain regulators
To: Linus Walleij <linusw@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Lee Jones <lee@kernel.org>, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDE1NiBTYWx0ZWRfX5cEvGrywWAzP
 XscejrGXfqgmF94tt5hSB2m8YOULlrXWPVznRJXrrUM/t8gp2OGt6k4dazWBiEqXVKkAohZtkOj
 uI/8joyWsW86tnKIR7Z8ZX6dqNkstkBOHyPCdke1C2ebuXBBuoaEIPqmDr5J+KOtU9oEW9F81MW
 mmuxDh1Pe6ZTVCvFuH5ilwmIYwtWximshHja1Sl4PNzKbGtwrYm7qkai9/o3MSyb39M4TfHVt86
 cT94qtED6soGPg/Snfmcvpn2B0ydvveO1OHGqEY4YehBmCbzRS9cmP77WLKMqvMJ/VkEUtkap2+
 oSmbcbdZtjwfKJElSU4kk7ltcux43U+uqB1x19gTkzsMizeiNBTRYeNrm+DzIrVLDXVpnVVyJ6K
 VRjMZDshlxk1sGv10zdRf/oaO8MnVJi1+vP9nvcnzfyB3KeGsxPDXot1rNvFy7MZ7Tq1a3Qa58B
 K5nVKHK+FUeDMhNkS7Q==
X-Proofpoint-GUID: alU9zoDlELTNJqQNmzhcG-LHpLBMUpjU
X-Authority-Analysis: v=2.4 cv=TMp1jVla c=1 sm=1 tr=0 ts=6a4e726c cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8 a=l53Gh-upYCO10StVhpkA:9
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDE1NiBTYWx0ZWRfX2OGADz/0nMcb
 p4JcapyGLZWpgIBNYpDWMAZ5l39R9DisVsTqoy2tza/3gyns2LxpZbXVRxLiWJfqvyRMPIkwh8B
 dLkxiUplh5cEcxMWbYgYCTV52NGTULc=
X-Proofpoint-ORIG-GUID: alU9zoDlELTNJqQNmzhcG-LHpLBMUpjU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_02,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607080156
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12122-lists,dmaengine=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linusw@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:ulfh@kernel.org,m:broonie@kernel.org,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:tzimmermann@suse.de,m:airlied@gmail.com,m:simona@ffwll.ch,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:lee@kernel.org,m:linux-arm-kernel@lists.infradead.org,m:devicetree@vger.kernel.org,m:linux-pm@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:dmaengine@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[ulf.hansson@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,suse.de,gmail.com,ffwll.ch,lists.infradead.org,vger.kernel.org,lists.freedesktop.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ulf.hansson@oss.qualcomm.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,vger.kernel.org:from_smtp,qualcomm.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5954D7284F4

On Thu, Jun 18, 2026 at 7:01=E2=80=AFAM Linus Walleij <linusw@kernel.org> w=
rote:
>
> Add a DB8500 regulator driver for the VAPE and VSMPS2 compatibility nodes=
.
>
> Back the regulator enable state with the corresponding power domains.
>
> This is done for off-chip consumers: the corresponding voltage rails are
> routed out so they are used for powering different peripherals using
> these voltages as supplies.
>
> Assisted-by: Codex:gpt-5-5
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
>  arch/arm/boot/dts/st/ste-dbx5x0.dtsi |   2 +
>  drivers/regulator/Kconfig            |  11 ++
>  drivers/regulator/Makefile           |   1 +
>  drivers/regulator/db8500-regulator.c | 221 +++++++++++++++++++++++++++++=
++++++
>  4 files changed, 235 insertions(+)
>
> diff --git a/arch/arm/boot/dts/st/ste-dbx5x0.dtsi b/arch/arm/boot/dts/st/=
ste-dbx5x0.dtsi
> index a6fef302c994..fd6a075e4c93 100644
> --- a/arch/arm/boot/dts/st/ste-dbx5x0.dtsi
> +++ b/arch/arm/boot/dts/st/ste-dbx5x0.dtsi
> @@ -673,6 +673,7 @@ db8500-prcmu-regulators {
>                                 // DB8500_REGULATOR_VAPE
>                                 db8500_vape_reg: db8500_vape {
>                                         regulator-always-on;
> +                                       power-domains =3D <&pm_domains DO=
MAIN_VAPE>;

Hmm, isn't this the other way around? The power-domains node should
have a regulator supply?

We may even consider to skip to model the regulator altogether and
make the power domain operate directly on the prcmu instead.

>                                 };
>
>                                 // DB8500_REGULATOR_VARM
> @@ -693,6 +694,7 @@ db8500_vsmps1_reg: db8500_vsmps1 {
>
>                                 // DB8500_REGULATOR_VSMPS2
>                                 db8500_vsmps2_reg: db8500_vsmps2 {
> +                                       power-domains =3D <&pm_domains DO=
MAIN_VSMPS2>;

Ditto.

>                                 };
>
>                                 // DB8500_REGULATOR_VSMPS3
> diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
> index acc698c17bd2..8db63d8d3fa4 100644
> --- a/drivers/regulator/Kconfig
> +++ b/drivers/regulator/Kconfig
> @@ -397,6 +397,17 @@ config REGULATOR_DA9210
>           converter 12A DC-DC Buck controlled through an I2C
>           interface.
>

[...]

Kind regards
Uffe

