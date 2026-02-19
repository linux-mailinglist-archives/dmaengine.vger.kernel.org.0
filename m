Return-Path: <dmaengine+bounces-8974-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UF90J+kGl2lWtwIAu9opvQ
	(envelope-from <dmaengine+bounces-8974-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 19 Feb 2026 13:49:45 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A0315EB38
	for <lists+dmaengine@lfdr.de>; Thu, 19 Feb 2026 13:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4FD7302B384
	for <lists+dmaengine@lfdr.de>; Thu, 19 Feb 2026 12:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0A8339858;
	Thu, 19 Feb 2026 12:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ORMQlgyK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eEAPeelV"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4162285C84
	for <dmaengine@vger.kernel.org>; Thu, 19 Feb 2026 12:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771505376; cv=pass; b=kaTx6AAFTYVSq16d8Av12CWlKZ5xzS9wSsK5wDxIOOas4qanu8MKCRUwB8f2uBrLAij8O+2s91H0f9kXlJpUQowzUwus9Kue+pmRuVkcvhDrjIe+kz0AInEQ/GROZR6s4LHcDc1olu+V6musPaeLJpEwg6MmrXvc3EkwPTwUbIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771505376; c=relaxed/simple;
	bh=Ttdv1MjLTh7dlTy4W0gmvcT80sPMOwSYIvTVAnKaV/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K+F6LlCyH+w2+UKojFq1dG/ttkBP7as6yUrvqZtgoHbguw27q7i6Cl3gSF3WSnOWnYMOGgF7200nU6MhHjKBVDoQKpyV2ICsrll94K/89ivbJl7TBpGnfoczVMeTBHuCJnHryt5JJQveCD0zX92y6K9efRO/4dkpsaT87dy423k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ORMQlgyK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eEAPeelV; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61JCOn0p1716250
	for <dmaengine@vger.kernel.org>; Thu, 19 Feb 2026 12:49:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ttdv1MjLTh7dlTy4W0gmvcT80sPMOwSYIvTVAnKaV/0=; b=ORMQlgyKYehudRvH
	X3jtjWranYueO8iQYh56j8V+M/VbmrIi5XMGEhCgEMEBBgPPQFs98kiVXarwuG0t
	14sZ1Ac1iONOZIN8zVy0zlieAp0PbJLFuw+l3QKAtPSvnk+yWXQPIVeDz7DeHjUz
	ml47D+yhAOAJ6SQvA73WwLaylzl2LwWyO/DxtnZPKHdMMx2pibdNfFYwgkZBQpn6
	L2DKM2B768BEbADem92UFPA/9i2MhEzUBDlx0nIHtFk6x5sxHn1/tjSDPS3VdsQ4
	fMD4KVoh2XCxenUxX45DQjBghYIFKptf3kTfzJ63YDuPgbVNR6FfySMTLLGwPeFW
	spx5Ig==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ce2ghr22v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Thu, 19 Feb 2026 12:49:34 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-35678f99c6eso571548a91.1
        for <dmaengine@vger.kernel.org>; Thu, 19 Feb 2026 04:49:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771505373; cv=none;
        d=google.com; s=arc-20240605;
        b=SzAKN8Cmo5ZBZ/ElrvHK4SP1nwrXV2FxDCUNjSPDJvqLCnbjA1ybYqLzZX9YzY57hI
         nMcsSfhXRq8PzX3bS02GZ0xPdL3H4jOWt36my8Kcvv+KSnlo6qmjfmofJwVfL347m5bC
         adFKgSlvay8lr/xdqGKUytGYqxV+dFBm8ngjyJerANeLqSm74aeNfaWrnJkelGhI5xhG
         qV+tzOZiACyP59QDbpeSAUJNLKe+tihpQz2DbvJfrEM1TOOPgAgZUOo2YXMZWJeD2uYf
         3N2iKxaRb5sUZ9XpZp45EbLa5c6kqyF2rGI6EqmUecrTHsGyut9my+BD2zkg38bfHgFA
         3+cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ttdv1MjLTh7dlTy4W0gmvcT80sPMOwSYIvTVAnKaV/0=;
        fh=sniJ6Ggb5WbO3gZc4yRhZcLuGctUwpb7e9T2FrEpj4I=;
        b=Xtd3xSk/p53A7oQZGF18dQWtq42FGm1WgJXFEjF9DxktvS4bP/I5NbCpKMIb9GPuOO
         oQZPCHCtHQP7rCq/epQub/3ZeFe3NxpjzU986nHhR5jLbSFwdZJIxkaVEXLOzCrOp77l
         7Rplg0M+FNoanZqhRuHWSn3N1soIyFXXIonAJLiCVYCk+GbhktWRZLxD72joqAfYBZB/
         cMcjG4FFvvYQ2A9pEiO179MeU82hRvCThBufivmi9pM1CgZ/KYSMSV6YmOd41slUrmuJ
         yFhTKQRoLG+8OoThcRerP5XhZJ8ZUkwoQ/ehWX+kaa1BD70sPyBE8kB76CZO2PCGj3G+
         el0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771505373; x=1772110173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ttdv1MjLTh7dlTy4W0gmvcT80sPMOwSYIvTVAnKaV/0=;
        b=eEAPeelVoWI6gH5urXvbCQX2egO0HPWPArdZZ5WS0v9Yh5spb0TgazHmVRdiRnzXvS
         XuYwZY+7eBnRHbiNtBpaQqxF/DAuH+I2x0tjTd/QqHRaiL2VGAEib0I80oBKA62kUB5E
         dcI1g5UIV0Wsgu8SX8erdQI5qByavFs2e5SUnPAy8J05K0Z8P7I/K2yGScjCFLzQ3Pfx
         mZSP06SkxHZd+5SgzfHBuSyoFl+5JECPXEe3WRsdZPliZKTn3h7LCpzarx+p0wZji14y
         3p85d/AcvyjOThjJ+sNwMXr6FFUOgMw9UVolFep4oQNS9jMz8A97sVrJOj3yVJxsnuEa
         9NkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771505373; x=1772110173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ttdv1MjLTh7dlTy4W0gmvcT80sPMOwSYIvTVAnKaV/0=;
        b=uR40kKTePTv/Sw0JgPdUSmdQqWMeI7IXw6sG6a2F4PhbgviDCTxN9zIEW003dMdzHN
         r/bckFQKjKto2erbsaqQx8lyrgawKL7/che3mQSHs/AuTzTz6tEDmnjFAaLYH1nYrh2K
         qvRvb/Cmlwzimy3f3C6H1gSp2I6Uem5W17uWvXmJ+sfCjp20PwvEYwaH9KG+Znfsioq1
         w28sBh8SmdWXMOXy8B5dVaywNM4NXaYPdrVJSg+2kPahqwMjGqaEK9DsH70F67x9VocC
         iR6mzbNXFNd3LsBu1YZSyhPjtGXzEc/Qco4z/DStReGeyfy6p15qrBSntNfFIxAAvoyI
         6dvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhw5cpV7PuLhiokra/7cZVEAiDGHSk/bgAW9cvvtB6wv2L5OFkt+7NYHEXETwU0kcJ6PZI3PpkLCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB3CvOdvy/FRN3LoHRi8zXZvHIl5/bzSu3qyPrD29rxNPXeMqh
	IrjLTe5J3p0XVJmmt58Nmc4FTubz4Wqy5132K/3V2VEaDRrt2cTY/a7VQmiQjsDFUtzHvMSmFVM
	ou6lfi48LfKNku0xgjZvEDonepP/JHxCIIOEZcom+J37VS3KqZUnyYOQ6w/tLwbJsEGj1n5xWak
	CqMkX0wnk+pAQqwCgup2ssM0Qbx3vh1rVcpZ6qjA==
X-Gm-Gg: AZuq6aIkb5VTvuWqV/9HMkrgvMCNUwIIAIxJCVrIYZ00BRi4I8KMc4fo32c+lBvnm3B
	USqzbH6tyVXA/bE+MhYxG2hMZC/HoSrE+mhDDmdth6DzcHCKzWNIcgfxZrvORW3n2utkEgrHnU/
	JZNo5746Isvf6wp0zyRcqNWLWOsStdx7IsbY3YrFHHqsVOTzkDOysqoGpmC/nsIGlQzqd34GoIT
	20fNRg=
X-Received: by 2002:a17:90b:2541:b0:343:6108:1712 with SMTP id 98e67ed59e1d1-35844f9bf28mr16822430a91.18.1771505373225;
        Thu, 19 Feb 2026 04:49:33 -0800 (PST)
X-Received: by 2002:a17:90b:2541:b0:343:6108:1712 with SMTP id
 98e67ed59e1d1-35844f9bf28mr16822399a91.18.1771505372734; Thu, 19 Feb 2026
 04:49:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aUF2gj_0svpygHmD@vaman> <CAMRc=McO-Fbb=O3VjFk5C14CD6oVA4UmLroN4_ddCVxtfxr03A@mail.gmail.com>
 <aUpyrIvu_kG7DtQm@vaman> <CAMRc=Md6ucK-TAmtvWMmUGX1KuVE9Wj_z4i7_-Gc7YXP=Omtcw@mail.gmail.com>
 <aVZh3hb32r1oVcwG@vaman> <CAMRc=MePAVMZPju6rZsyQMir4CkQi+FEqbC++omQtVQC1rHBVg@mail.gmail.com>
 <aVf5WUe9cAXZHxPJ@vaman> <CAMRc=Mdaucen4=QACDAGMuwTR1L5224S0erfC0fA7yzVzMha_Q@mail.gmail.com>
 <aWBndOfbtweRr0uS@vaman> <CAMRc=McPz+W4GOCbNMx-tpSav3+wuUrLT2CF5FhoV5U29oiK6A@mail.gmail.com>
 <ana2ugshqjicqscwpdgo6knv53n4zzuwqp376qil27spco5vwh@ck7wmplz52qs>
In-Reply-To: <ana2ugshqjicqscwpdgo6knv53n4zzuwqp376qil27spco5vwh@ck7wmplz52qs>
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 19 Feb 2026 14:49:21 +0200
X-Gm-Features: AaiRm51o4g31g965N2gH-SXwl6Om40wgrXBqrOnB0nlpO7IeBLGRHVAFs5LGkbM
Message-ID: <CAO9ioeWaFLo_iirfTEatoL+MXDXoyS1OvSV6SqT3xUs5LmWpqQ@mail.gmail.com>
Subject: Re: [PATCH v9 03/11] dmaengine: qcom: bam_dma: implement support for
 BAM locking
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Udit Tiwari <quic_utiwari@quicinc.com>,
        Daniel Perez-Zoghbi <dperezzo@quicinc.com>,
        Md Sadre Alam <mdalam@qti.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>, dmaengine@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: 8zi0LirO41LTxcmGG875nBG--fHB-hSE
X-Authority-Analysis: v=2.4 cv=dqzWylg4 c=1 sm=1 tr=0 ts=699706de cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=CNITKJuBw3o7r-kFhd8A:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE5MDExNyBTYWx0ZWRfX6OYq4GpurxkB
 PnTdARbaRInGBcyki5KYnG0HmVqN2g0hBH+a9Uw6OjICT6XIA4uG/yf8sw218Cvxq4dWw6QynNF
 TAuTUMScMVa1nZrfZYEEFhV6d5EHn6X+uYbuxDmXNiUkPyczpo6JB0a74SyNpcE73eVoAJjT3Qh
 b153tzcraK8WDrexskenNkkq+AtTfOOODCpNgHykbUFrqO5bxhMmBbb/r/VoiG8qedjvE3UxFHJ
 WqYhyLWxGjylNBoXz7Di1LYGavvJkA4IXD+Z4ytKc3bYVNWQvYRkcqydlVoDbKgcXjAqKDVY1MD
 NSY3YVjHKBw9OgFf68gfOPkYHGYk11Xwb4WuXhg1fqlD1xcw3VrzYRyro2Y4ZSbRbSSGCxp0yty
 bJvrZPUp1RhtBciFa5EtfqrS/tC+rYGzigRvxouWtWELXh4Z8TpxUkEitszN0RECWdF8E2so2SP
 T+qglsd1ftmgpV9hJjw==
X-Proofpoint-GUID: 8zi0LirO41LTxcmGG875nBG--fHB-hSE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_03,2026-02-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602190117
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8974-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,vger.kernel.org,linaro.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 00A0315EB38
X-Rspamd-Action: no action

On Thu, 19 Feb 2026 at 14:12, Manivannan Sadhasivam <mani@kernel.org> wrote=
:
>
> On Fri, Jan 09, 2026 at 03:15:38PM +0100, Bartosz Golaszewski wrote:
> > On Fri, Jan 9, 2026 at 3:27=E2=80=AFAM Vinod Koul <vkoul@kernel.org> wr=
ote:
> > >
> > > >
> > > > We need an API because we send a locking descriptor, then a regular
> > > > descriptor (or descriptors) for the actual transaction(s) and then =
an
> > > > unlocking descriptor. It's a thing the user of the DMA engine needs=
 to
> > > > decide on, not the DMA engine itself.
> > >
> > > I think downstream sends lock descriptor always. What is the harm in
> > > doing that every time if we go down that path?
> >
> > No, in downstream it too depends on the user setting the right bits.
> > Currently the only user of the BAM locking downstream is the NAND
> > driver. I don't think the code where the crypto driver uses it is
> > public yet.
> >
> > And yes, there is harm - it slightly impacts performance. For QCE it
> > doesn't really matter as any users wanting to offload skcipher or SHA
> > are better off using the Arm Crypto Extensions anyway as they are
> > faster by an order of magnitude (!). It's also the default upstream,
> > where the priorities are set such that the ARM CEs are preferred over
> > the QCE. QCE however, is able to coordinate with the TrustZone and
> > will be used to support the DRM use-cases.
> >
> > I prefer to avoid impacting any other users of BAM DMA.
> >
>
> Sorry for jumping late. But I disagree with the argument that the client =
drivers
> have to set the LOCK/UNLOCK bit. These bits are specific to BAM DMA IP fo=
r
> serializing the command descriptors from multiple entities. So DMA client=
s like
> Crypto/NAND have no business in setting this flag. It is the job of the B=
AM
> dmaengine driver to set/unset it at the start and end of the descriptor c=
hain.

Is it really granular to the single DMA chain or can it be required
for the BAM to be locked for more than single DMA chain?

>
> > > Reg Dmitry question above, this is dma hw capability, how will client
> > > know if it has to lock on older rev of hardware or not...?
> > >
> > > > Also: only the crypto engine needs it for now, not all the other us=
ers
> > > > of the BAM engine.
> > >
> >
> > Trying to set the lock/unlock bits will make
> > dmaengine_desc_attach_metadata() fail if HW does not support it.
> >
>
> The BAM dmaengine driver *must* know based on the IP version whether it s=
upports
> the LOCK/UNLOCK bits or not, not the client drivers. How can the client d=
rivers
> know about the BAM DMA IP capability?

How do blocks know about capabilities of other blocks? If there is no
API for getting those we can encode platform peculiarities into the OF
match data.

>
> For all these reasons, BAM driver should handle the locking mechanism int=
ernaly.
> This will allow the client drivers to work without any modifications.
>
> FWIW, NAND driver too is impacted by this missing feature in the BAM driv=
er as
> both Modem and Linux tries to driver BAM and currently Linux BAM driver d=
oesn't
> set these bits leading to crashes.
>
> - Mani
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D



--=20
With best wishes
Dmitry

