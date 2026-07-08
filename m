Return-Path: <dmaengine+bounces-12120-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0HbnNgF3TmonNQIAu9opvQ
	(envelope-from <dmaengine+bounces-12120-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 18:12:49 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3968B72881F
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 18:12:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=Gpi7Z0iH;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=MOacMMU8;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12120-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12120-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A80F320544C
	for <lists+dmaengine@lfdr.de>; Wed,  8 Jul 2026 15:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B5C32ED3A;
	Wed,  8 Jul 2026 15:43:29 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2995630D406
	for <dmaengine@vger.kernel.org>; Wed,  8 Jul 2026 15:43:27 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783525409; cv=pass; b=mPKB4I3ThjBpC4DKtmzaG39PFXjkTiXhHOGL0t8lEUhMr5vdr89xXTt3+G0S/QtzAT30QTBrLj6iVoO5v/YgLpAGXoAuqt7uvY7N2Eogc9BLO+MnrDo7jb2pXa0UL9T1mwMVxnCj0wgdSRvbkhNz0KQ+hoPVjqy4dvWOJA+3a3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783525409; c=relaxed/simple;
	bh=V4fIwFsr0mLwchZrRcsUWwCmrPaULkaS8mPw6q6+HMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mbP/yfQErxt/WRKATmBdK7nh1GZVom5nrV1rDR5pMZbRuazHCy6L9O8X2kgidSskAct+xVbrCprHthtjyxC2RPdEwQbRKxqIGt7b5XFMnOXZmdPobJgr7Wb0QxkHG6MCWW1LYPfpkFtunbQOG+K4+sHwdZhYlOJsqFWvroKHwpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Gpi7Z0iH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MOacMMU8; arc=pass smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668D7pih2677922
	for <dmaengine@vger.kernel.org>; Wed, 8 Jul 2026 15:43:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OW7Jo5BTMAK0p//WyaSFrL7dEi1HJV9QqxfZvItnF1A=; b=Gpi7Z0iHanVc4ewT
	7FQ/iOmgIDYfQPNsLWBPahVUdstaYgfQlDtGjG8VdQQA7J4awDImmOUNWK7vXyEM
	tSCOlLcy4XHryPydn5GaRVu0CuNO/LMFBPRrPiUtLOo8SoV/IcsywNpNveG3cn6g
	VDgjqyDZIdd4vgQqIb9ZYLZc55+qR8tBPSNrjrvHWDGsX/3Tk3aD30L/o2F4t6w2
	zphI+wMiWRJYxTClL0K5W1KWq+cUBGielBfTLp041HPpIH7eneORQez1UM2tN+J/
	M9UK/hSLMSNSRYjxhJwXnpci8Kuk8ap5IbJmXjvS3+m3abiBsrAgD6FN7RfdohoZ
	qd31EQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9q5s8r8h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Wed, 08 Jul 2026 15:43:27 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c21c01cf3so17099321cf.2
        for <dmaengine@vger.kernel.org>; Wed, 08 Jul 2026 08:43:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783525406; cv=none;
        d=google.com; s=arc-20260327;
        b=I5UWgI0qo+3NPzn0t0+fxcnwtmtnCpSgSz/vc0vB16lymq4WKd8wLDmTpf+5Jl6v9z
         Zomy+un5pLkBJPm50K+BwGfffBoAq5UzsuYShIRy2YuOGl6GxbdwHIbZMq4x1GWz7SWg
         BVXb+QMm+CGEwwGZehAbgPgwhCa6PY42IBFQrXTJNY7d+DR3gVl83JakTxG+vk3l87LR
         VD8hJD10fLnrhOLJ5i01ROHJzdmE7JT8gogN+knSKCvNtgm6WmvohvU4Ja/zvYCgq5cj
         dGiqxitRUZHntiP3lhJGM91hYHYPlb1xNtShCqHBpSMApTQLZIniRsWcIBjNJxXKp9Ew
         ui6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OW7Jo5BTMAK0p//WyaSFrL7dEi1HJV9QqxfZvItnF1A=;
        fh=y/FIWtfBtnyJNQefoLnZFccFL7uPodEk4NHk6JyYfRs=;
        b=ri2OIdswyodgPF3Gy8Tl0Yw8c5IksD4A17yuV1EkW/nwB95Tso6gd0Iu/D+/Yvmy8q
         EnfE2v6qOpVZ5f5fXBb+zu7jbnz+LCakpvcgwESGit6L3D4GVUSy5CRZpjRRYP1o2vDM
         8uPqTtQdi2byD7BBXGrLazw74EoM4ftHYWdiSlaqpwYL17xjIj8zq5VYIj/f96Q3Oofc
         VvZf4om4SclqcwpHVOp0+QpZ0qby5ufHVLHPhGu7Ejm7d7Q/lXjVbzBhNKto2r1FhdqE
         XG+TsK0ycJ9FFVimpWJN7YT54wibnsGaPfxB7XQq8O+VFCvrxa3Wo0hH8zSwowkh5cC3
         Uz/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783525406; x=1784130206; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OW7Jo5BTMAK0p//WyaSFrL7dEi1HJV9QqxfZvItnF1A=;
        b=MOacMMU8HWj6thFPlNXD6/yKqt+zpiOy3WfdCpFPG8zc7MCxepTZVxE+GL5hn3917Z
         Vn5YYOtqfhHA1L1lo6OIekPpHNxmNyykUTucgaqnzOQKaUnF5hCBFWjVJxX80U+u5qUb
         8+LKrQY/7QrZm00APbVttvfUf8GjETFr73QJ47fjaU1GzguhlAf4FlylEmaB9umu0Mn1
         gcY9DVkQJ3tF8YbQeZOGX4OTByvnma/CgFQ82eWM4jHJUs02c3dep2nEPSx7OqWnnw9D
         z8Q+zbyTeqp0VO1kqcWv6w2ihFglfgFtE5gL7VsT9QuzR+bChZVoKtIuMLPv9ZeYfkg8
         O+TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783525406; x=1784130206;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OW7Jo5BTMAK0p//WyaSFrL7dEi1HJV9QqxfZvItnF1A=;
        b=cCXZ4F6lKZZLVqPGt8ssTK6jZ5dMyhaQ2E7rWWaVAEhcWUac5Alu5vdlsipICI5Woc
         hA1kq2GIVrlYDsIns1ll7/VXcjn1ZZPBNUBoB6JhoOlxJZ7ftY+vCeHOD/uOJsf8SZHp
         2EnRUy1Dbxt9fM/G/qi1gGhDuO67dR/yu5mwjbVT4+Hd3YY6rn2Pd5UnbrHqOUwYtVkS
         qvJPJ7oEwWVgnArJPLtXgH2f4DXYeGtrrHmSrGIf0Y42YtXpC/HcfxAH6MElkxxxbnnX
         inhFKuw9RIg11dqJR1U8/59lAcWFlEdL46YP4/9M+UWB18nOyCRlZ4lsGBCeSIpHYLxw
         Bg9A==
X-Forwarded-Encrypted: i=1; AHgh+RrxVVlygnoTqo6Cqwexc2PLK/4j7ShREBTEcZtFaTPDlQstK3IzRj2hUrR95qucOglH0nZJBbDpDL0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw8OadnfU9VZKy8x9Lqj/xjcQ7KKhNx4i3556OcW+HDsleHupZ
	hhW3+8qZn6THISgaucEGjuKiCTrAHYwBWqJU860imtINv2piZBYxve4ocsEcab1iyKO/wOXX4XS
	41SwA69B24jeegWE/9jGhNcNWM3Qk8qEd71I6eJ5KNDmut18nQnNId74ggpPNd8HH8InQNnsyqH
	vYmIXeoKSne0EWoxI9wENldtnFC4Z67DSEGfNwMA==
X-Gm-Gg: AfdE7cn313fGrD4tThhE2gI7JXXZ9oAJxC30tB3fq482nZu/tx/ftDoaCEtU98ZeT5Y
	7lBFoJkC9AA2l/MY816mZsezt9FqTnv+XWb35UZ/zMwpvLUyBsVlDFYs7F5IsVVgqzw95O02adq
	Lw29EKPXIS8IUGkPvsEFiwv8L262nS46HUFV2rbG5ambIiiGTLseJcEELQyLoQiBr3dI9k
X-Received: by 2002:a05:622a:4c05:b0:51a:8b64:69e0 with SMTP id d75a77b69052e-51c8b398897mr31022761cf.11.1783525406143;
        Wed, 08 Jul 2026 08:43:26 -0700 (PDT)
X-Received: by 2002:a05:622a:4c05:b0:51a:8b64:69e0 with SMTP id
 d75a77b69052e-51c8b398897mr31022071cf.11.1783525405268; Wed, 08 Jul 2026
 08:43:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618-ux500-power-domains-v7-1-v1-0-eb5e50b1a588@kernel.org> <20260618-ux500-power-domains-v7-1-v1-6-eb5e50b1a588@kernel.org>
In-Reply-To: <20260618-ux500-power-domains-v7-1-v1-6-eb5e50b1a588@kernel.org>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 8 Jul 2026 17:43:14 +0200
X-Gm-Features: AVVi8Cdq0rtjAP0YSg4WhxzCqmLPP1um1vAPUHWXvoo9MmpPquQaWcjqsUHRPk4
Message-ID: <CAPx+jO-teiu9vQfw+MeTbixH4PnARaqSC+_7bvHUMAAEPqtDaQ@mail.gmail.com>
Subject: Re: [PATCH 06/11] pmdomain: st: ux500: Control DB8500 EPODs
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDE1NSBTYWx0ZWRfXy5ATAgyYi/ao
 b417Fh84y70X6ATsRP9FAwyVY78POZhtcbpcjCBRMj8zEkLyoqWOQD29NPu3GZgy8vX1uKbIatQ
 DoU4KBB6rNAVf/z0cQuKrWfybcNjxN7eQkcA3jSFIKdFyuAYBh6bzU/uWnu01gZ+YJw7M2Dn0+s
 2VmwzbXfSsnJVM+7KL6pYqWQetdiSZhNDtjqhqy11geXUhdNjkRbVJ4nYLHtthHpMCDkWe0LIOS
 AOXvAxTBm2wQpei0FfDAKMVJglh3YDue8DHVZV7ivnomos9fN+rJTwNnIcpRyCaK6e/hhWHiaCn
 PaOJuEkzYV+/D6qmqVmJbxa0enIaYUu+M7NPV3hjzuLUcu6CjVpeAfkOHLpnbBWXVJUHarBQPc9
 60AODKZq8y8JqNyRr6+vxFQgazvm+Emjbm2l6WI/eRfoTIyT/HL569CqSNvVA03TPp6xXFyNgTA
 IMAbEexGUzW9Ab5uCMQ==
X-Proofpoint-ORIG-GUID: sM5unAecM79N8zNM7NqUA-1DSx43AgeX
X-Authority-Analysis: v=2.4 cv=NfTWEWD4 c=1 sm=1 tr=0 ts=6a4e701f cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8 a=-O4hDVTBhx9-GJANRbkA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDE1NSBTYWx0ZWRfXyhfb/UIJXYjL
 hpUmqFvIi9fzd40p9jOPruKVvtNa0K/8zYZPSz5y5AHK7V7hQS7aj0GqrbT4V2+JjtBiadVcsky
 Te2nKepOAlSrIQpdoAoXBIpT3BEye6Y=
X-Proofpoint-GUID: sM5unAecM79N8zNM7NqUA-1DSx43AgeX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_02,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1011
 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607080155
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12120-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3968B72881F

On Thu, Jun 18, 2026 at 7:01=E2=80=AFAM Linus Walleij <linusw@kernel.org> w=
rote:
>
> Move the DB8500 EPOD state handling into the Ux500 power-domain driver.
>
> Keep the old regulator driver mutually exclusive with the pmdomain driver=
.
>
> Assisted-by: Codex:gpt-5-5
> Signed-off-by: Linus Walleij <linusw@kernel.org>
> ---
>  arch/arm/mach-ux500/Kconfig               |   2 +-
>  drivers/pmdomain/st/ste-ux500-pm-domain.c | 380 ++++++++++++++++++++++--=
------
>  drivers/regulator/Kconfig                 |   1 +
>  3 files changed, 282 insertions(+), 101 deletions(-)
>
> diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
> index c18def269137..56636c993f49 100644
> --- a/arch/arm/mach-ux500/Kconfig
> +++ b/arch/arm/mach-ux500/Kconfig
> @@ -26,7 +26,7 @@ menuconfig ARCH_U8500
>         select PL310_ERRATA_753970 if CACHE_L2X0
>         select PM_GENERIC_DOMAINS if PM
>         select REGULATOR
> -       select REGULATOR_DB8500_PRCMU
> +       select UX500_PM_DOMAIN
>         select REGULATOR_FIXED_VOLTAGE
>         select SOC_BUS
>         select RESET_CONTROLLER
> diff --git a/drivers/pmdomain/st/ste-ux500-pm-domain.c b/drivers/pmdomain=
/st/ste-ux500-pm-domain.c
> index 723001004690..1cd5b4985db0 100644
> --- a/drivers/pmdomain/st/ste-ux500-pm-domain.c
> +++ b/drivers/pmdomain/st/ste-ux500-pm-domain.c
> @@ -6,172 +6,315 @@
>   *
>   * Implements PM domains using the generic PM domain for ux500.
>   */
> +#include <linux/cleanup.h>
>  #include <linux/device.h>
> +#include <linux/err.h>
>  #include <linux/kernel.h>
> +#include <linux/mfd/dbx500-prcmu.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
>  #include <linux/printk.h>
>  #include <linux/slab.h>
> -#include <linux/err.h>
> -#include <linux/of.h>
> -#include <linux/pm_domain.h>
>
>  #include <dt-bindings/arm/ux500_pm_domains.h>
>
> -static int pd_power_off(struct generic_pm_domain *domain)
> +#define UX500_EPOD_NONE                NUM_EPOD_ID
> +
> +/**
> + * struct dbx500_powerdomain_info - dbx500 power domain information
> + * @genpd: generic power domain
> + * @epod_id: id for EPOD (power domain)
> + * @is_ramret: RAM retention switch for EPOD (power domain)
> + * @exclude_from_power_state: exclude domain from power state count
> + */
> +struct dbx500_powerdomain_info {
> +       struct generic_pm_domain genpd;
> +       u16 epod_id;
> +       bool is_ramret;
> +       bool exclude_from_power_state;
> +};
> +
> +static DEFINE_MUTEX(ux500_pd_lock);
> +static int power_state_active_cnt;
> +static bool epod_on[NUM_EPOD_ID];
> +static bool epod_ramret[NUM_EPOD_ID];
> +
> +static void power_state_active_enable(void)
> +{
> +       power_state_active_cnt++;
> +}
> +
> +static int power_state_active_disable(void)
>  {
> -       /*
> -        * Handle the gating of the PM domain regulator here.
> -        *
> -        * Drivers/subsystems handling devices in the PM domain needs to =
perform
> -        * register context save/restore from their respective runtime PM
> -        * callbacks, to be able to enable PM domain gating/ungating.
> -        */
> +       if (power_state_active_cnt <=3D 0) {
> +               pr_err("power state: unbalanced enable/disable calls\n");
> +               return -EINVAL;
> +       }
> +
> +       power_state_active_cnt--;

The whole power_state_active_cnt thing seems to be a leftover from
debug exercise, no?

At least, I can't see that it actually adds much - or maybe following
patches makes use of it somehow?

>         return 0;
>  }
>
> -static int pd_power_on(struct generic_pm_domain *domain)
> +static int enable_epod(u16 epod_id, bool ramret)
>  {
> -       /*
> -        * Handle the ungating of the PM domain regulator here.
> -        *
> -        * Drivers/subsystems handling devices in the PM domain needs to =
perform
> -        * register context save/restore from their respective runtime PM
> -        * callbacks, to be able to enable PM domain gating/ungating.
> -        */
> +       int ret;
> +
> +       if (ramret) {
> +               if (!epod_on[epod_id]) {
> +                       ret =3D prcmu_set_epod(epod_id, EPOD_STATE_RAMRET=
);
> +                       if (ret < 0)
> +                               return ret;
> +               }
> +               epod_ramret[epod_id] =3D true;
> +       } else {
> +               ret =3D prcmu_set_epod(epod_id, EPOD_STATE_ON);
> +               if (ret < 0)
> +                       return ret;
> +               epod_on[epod_id] =3D true;
> +       }
> +
> +       return 0;
> +}
> +
> +static int disable_epod(u16 epod_id, bool ramret)
> +{
> +       int ret;
> +
> +       if (ramret) {
> +               if (!epod_on[epod_id]) {
> +                       ret =3D prcmu_set_epod(epod_id, EPOD_STATE_OFF);
> +                       if (ret < 0)
> +                               return ret;
> +               }
> +               epod_ramret[epod_id] =3D false;
> +       } else {
> +               if (epod_ramret[epod_id]) {
> +                       ret =3D prcmu_set_epod(epod_id, EPOD_STATE_RAMRET=
);
> +                       if (ret < 0)
> +                               return ret;
> +               } else {
> +                       ret =3D prcmu_set_epod(epod_id, EPOD_STATE_OFF);
> +                       if (ret < 0)
> +                               return ret;
> +               }
> +               epod_on[epod_id] =3D false;
> +       }
> +
>         return 0;
>  }
>
> +static int pd_power_off(struct generic_pm_domain *domain)
> +{
> +       struct dbx500_powerdomain_info *info =3D
> +               container_of(domain, struct dbx500_powerdomain_info, genp=
d);
> +       int ret =3D 0;
> +
> +       guard(mutex)(&ux500_pd_lock);
> +       if (info->epod_id < NUM_EPOD_ID)
> +               ret =3D disable_epod(info->epod_id, info->is_ramret);
> +       else if (!info->exclude_from_power_state)
> +               ret =3D power_state_active_disable();
> +
> +       return ret;
> +}
> +
> +static int pd_power_on(struct generic_pm_domain *domain)
> +{
> +       struct dbx500_powerdomain_info *info =3D
> +               container_of(domain, struct dbx500_powerdomain_info, genp=
d);
> +       int ret =3D 0;
> +
> +       guard(mutex)(&ux500_pd_lock);
> +       if (info->epod_id < NUM_EPOD_ID)
> +               ret =3D enable_epod(info->epod_id, info->is_ramret);
> +       else if (!info->exclude_from_power_state)
> +               power_state_active_enable();
> +
> +       return ret;
> +}

[...]

>
> +static int ux500_pm_domain_add_subdomain(struct generic_pm_domain *domai=
n)
> +{
> +       return pm_genpd_add_subdomain(&ux500_pm_domain_vape.genpd, domain=
);
> +}
> +
> +static int ux500_pm_domains_add_subdomains(void)
> +{
> +       int ret;
> +
> +       ret =3D ux500_pm_domain_add_subdomain(&ux500_pm_domain_sva_mmdsp.=
genpd);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D ux500_pm_domain_add_subdomain(&ux500_pm_domain_sva_pipe.g=
enpd);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D ux500_pm_domain_add_subdomain(&ux500_pm_domain_sia_mmdsp.=
genpd);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D ux500_pm_domain_add_subdomain(&ux500_pm_domain_sia_pipe.g=
enpd);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D ux500_pm_domain_add_subdomain(&ux500_pm_domain_sga.genpd)=
;
> +       if (ret)
> +               return ret;
> +
> +       return ux500_pm_domain_add_subdomain(&ux500_pm_domain_b2r2_mcde.g=
enpd);
> +}

We recently added a generic "power-domains-child-ids" DT property,
that allows us to describe child power-domains for these kinds of
cases.

Moreover, we have of_genpd_add|remove_child_ids() to easily hook them
up when probing. I suggest we use that here as well.

> +
>  static int ux500_pm_domains_probe(struct platform_device *pdev)
>  {
>         struct device_node *np =3D pdev->dev.of_node;
>         struct genpd_onecell_data *genpd_data;
>         int i;
> +       int ret;
>
>         if (!np)
>                 return -ENODEV;
> @@ -196,7 +372,11 @@ static int ux500_pm_domains_probe(struct platform_de=
vice *pdev)
>         genpd_data->num_domains =3D ARRAY_SIZE(ux500_pm_domains);
>
>         for (i =3D 0; i < ARRAY_SIZE(ux500_pm_domains); ++i)
> -               pm_genpd_init(ux500_pm_domains[i], NULL, false);
> +               pm_genpd_init(ux500_pm_domains[i], NULL, true);
> +
> +       ret =3D ux500_pm_domains_add_subdomains();
> +       if (ret)
> +               return ret;
>
>         of_genpd_add_provider_onecell(np, genpd_data);
>         return 0;
> diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
> index 87554ab92801..35d1b191462c 100644
> --- a/drivers/regulator/Kconfig
> +++ b/drivers/regulator/Kconfig
> @@ -414,6 +414,7 @@ config REGULATOR_DBX500_PRCMU
>  config REGULATOR_DB8500_PRCMU
>         bool "ST-Ericsson DB8500 Voltage Domain Regulators"
>         depends on MFD_DB8500_PRCMU
> +       depends on !UX500_PM_DOMAIN
>         select REGULATOR_DBX500_PRCMU
>         help
>           This driver supports the voltage domain regulators controlled b=
y the
>
> --
> 2.54.0
>

Kind regards
Uffe

