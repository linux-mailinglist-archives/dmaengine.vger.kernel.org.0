Return-Path: <dmaengine+bounces-10859-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNPPLlsoFGrfKAcAu9opvQ
	(envelope-from <dmaengine+bounces-10859-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 12:45:47 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 27FD65C957C
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 12:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5640A301CA68
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 10:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93592372662;
	Mon, 25 May 2026 10:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Pbx/bydp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="M7yGZl8m"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C7636F91A
	for <dmaengine@vger.kernel.org>; Mon, 25 May 2026 10:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779705848; cv=none; b=awFtJT8n7Yy6cjZMQ5vqqFDiA94P3UwtWyrG/iWgC83l+iVeRFMUtkU43wo7fWFz/RnKopbXQyifAf7Itts9+hmLYuHhmS+TmYNxYhI9OADSDWn5MN2KTRPULkhyFtlLVA4tRDl/ux/mwtF7S30Km3hscLFtPlBDGFOch11TTQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779705848; c=relaxed/simple;
	bh=h/uqjF3R3sz2YKYkVBCkZA1z2qZxypPsZhVBXAZQnQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t7Ngx9anQ088kl75u709wNx3dqFkQd2Ac7bLOJfAtfhtZoFg5pAbzD6dJEXiWK/CyuU+IU4YSKqOVs8hKN+s83L2Du2IdWtX0nfLZcif4/JcPCc5ZNKU42S/faC2jXKYqi9Dee2j6zK5WitIu/yiuWcFnhuSraUp3X/eoFz5p00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Pbx/bydp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=M7yGZl8m; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64P9cjdE1802476
	for <dmaengine@vger.kernel.org>; Mon, 25 May 2026 10:44:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Z1raWWhLV0vMOZgDp8fhNzwX
	X9rXSsNT5f68RVt1IR8=; b=Pbx/bydpwQyQYuMslTHRkLL4d+B4FFarFnUiFEtQ
	nfjVfqqnpE1888w+zQ/1LKvErVSPgda8jYbtOdBHGN7q8JHna9pjtoSwP9DVr/GP
	alz465/XGeLqOUQ7XksPA9I0zOWj47T1wbIQW2iAV5bJ/NVTHoEUs3Y/EFwQQcXy
	qOb7GLuDgRub0JzWPheKVNfad4QrCyU4wp4kPvn1b4u7Vn+ze6VPVuDKVVqrIhUX
	DUfAmo9RTbs3Qmkm2MuGjq8dZQKo2cLyTOeEEc3dfZ8gElVks2pNI3cxMOGnAWtp
	aL7CFmncY4aHBvVZIqMRicBub7OA3TYCJWHKbZvMPkiazA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eckyqg7kx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 25 May 2026 10:44:03 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50faf575af4so246231101cf.0
        for <dmaengine@vger.kernel.org>; Mon, 25 May 2026 03:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779705843; x=1780310643; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z1raWWhLV0vMOZgDp8fhNzwXX9rXSsNT5f68RVt1IR8=;
        b=M7yGZl8mrd+GW1/lCmROMiSBCIVn7OheKqCWe9/xr5BopDRgJO/+YHyGephHV5oBDb
         We8f46OV2qmuavVgXx8emJZ/QwGaIkkPIN5tEgcZBOf3dhA6ZRPc1gr7U4Wo1ThE3eau
         7xwbRfGjtXQrm181jvVh0OD3lrboWiWSWp9xarc7h5U8vDWPwmEqHgn829oHAtU2sex8
         Kz+8Ti9rL6C+gN702QKezwS5HC6kQoM9qeXZOZq0S8etm6HPOaX4u1jtqm9pihBqgNC6
         FaVd4F+yJy8kZlBH74eOPIIr/A9vq4kf5KmE0xyba1J/9hrM2CBJgBQWb2tZbPwoveTc
         QC+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779705843; x=1780310643;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z1raWWhLV0vMOZgDp8fhNzwXX9rXSsNT5f68RVt1IR8=;
        b=L4raMKwf1NPUze7Ompc0YrEUSzymIyA1cRC1H8Nq5IMA/F4Lp5+uoCoDKnx6rbHiQ3
         4Kmf+Ft67snxT57m713oddXOP5+/UMRlbs7C9rB6IMeiFxihX3mPP+boF5onEFCXlZeE
         12bCWeueVl1S8iUgHyf40ILLeHdXHKhQvBDNPfC3svJr5TyMG5UoK44fupvLOvHHX4LH
         4pnGmlkQ2kR8YF+AzqGi/2UeUH5iUCWaoBdPcOpNP7daYl5o/uaZ5JYscA2UVeYPgsc+
         FJRp794isK2lapHqFxFt3QB+aygkCqg3SbxwqlVhS2NryEqi73zmm8/ufuJZ9f+cDza4
         erSQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Jh+y4lXex0MnuoPwGcRZ9TABKE2VljP5EBZmj/X761kQbF/queL6vuooXtt5Ge6ekAKNkCWWXloA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ+1BXNXrFE+UAHvy7D70mvrxxjH+or8tMUHR1DNrlcq+1vhek
	MMCWpTOpjQ56N/vE4YXahnbMNuWgRJ/+V5n/9uvQBqUK0kbc71lmDPlcZayd93QTkbEG9/vazEJ
	5EBu7qd5uQSC5TXKeVAgVMsHszrbrXGtt3rRtMSujVIVHndAAKpDRcXKw4tA1qnY=
X-Gm-Gg: Acq92OH0s2eXkxgO2lTj4aiFcAmkzTxwg8boGUl6+3wpCL/FCCcpyHpI9cOaSiocAiX
	VkVrGe+5fGfINpvfZ6bwS5XTl903zW1I2kGfNasJ9o9kzJP62bA11YLHElx6qpFGZyzQWFkIGZM
	WuUMnwVDnAul7L0ZPhs2JUp2Tp2NVBBNSJil1O6H+ehNOLPCt/4pVCnhsYErTEFHgmU5/5s9eI9
	90AENImDoEk45MUC3LKZaLKuS6Na5td2kpWkCJFJSrHu3hPC655GiWVTaCtKVCZ1nPPjHRfwoL2
	YD0nCL9FwaE2AGaZ2GIgRG6kFzKfrutF8d8fkiyzT/E+ODHsyokIySUVGRewNSt61YNN98eAqcs
	lKPAxidHaR1ApNtuzdso0czMl536IRRBZ7L7wBk6q6wEuTpcLu30+vzBvlvmH1PS/g6HLc/PEK8
	woZai2+LC++vwfgMOQhmeYX5N0+GKgtivswYM=
X-Received: by 2002:a05:622a:418b:b0:50f:be4f:465e with SMTP id d75a77b69052e-516d466fb5dmr185267081cf.53.1779705843012;
        Mon, 25 May 2026 03:44:03 -0700 (PDT)
X-Received: by 2002:a05:622a:418b:b0:50f:be4f:465e with SMTP id d75a77b69052e-516d466fb5dmr185266741cf.53.1779705842593;
        Mon, 25 May 2026 03:44:02 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-395dcc0a9d8sm22226301fa.26.2026.05.25.03.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 03:44:01 -0700 (PDT)
Date: Mon, 25 May 2026 13:43:59 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Frank Li <Frank.Li@kernel.org>, Andy Gross <agross@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: qcom: shikra: Add qcrypto node support
Message-ID: <cadke5cbqfnnbcwlafgajy6g2xj3s2apmtpzp5uwb5limtehyx@4nnoww2kmytp>
References: <20260515-shikra_qcrypto-v1-0-80f07b345c29@oss.qualcomm.com>
 <20260515-shikra_qcrypto-v1-3-80f07b345c29@oss.qualcomm.com>
 <8dfa0670-7605-497b-9d53-db9b4a8a3d8d@oss.qualcomm.com>
 <57c26520-42dd-4159-bd2a-69874945cbbe@oss.qualcomm.com>
 <algvollvttjlu4qpawi3gnhwponwml6pts47ebmcvrjvlryl3a@qjq5ildo4qsm>
 <8a1d6c78-fd16-4994-bae9-cf75b1e7e3c5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a1d6c78-fd16-4994-bae9-cf75b1e7e3c5@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=RMyD2Yi+ c=1 sm=1 tr=0 ts=6a1427f3 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=eCBvbIXyoX1lJJg6tWAA:9
 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: j5yrQEtjJSqM1ByVFyaazDVyJsWJfSva
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDEwOSBTYWx0ZWRfX4BRvF2xmDiPt
 jN/KLON9lIJb3k+ICTkeOisj7cDgf/eSqCjJpojykLHPB+LwBqW/hu8cnmgkqrFCwVA+DuoThBL
 j6pIiK7x6rgixkAO+eDmi3RkTMEFs7fHGOaeIkJ6gdGBFCER7AcZSC2HFdg2BNM4v/v4GfEDngY
 8vmCNyMDulS3qtpY4w/eFTJqHSKY0kz30wBwd7du/lrFnbcLJuktc+FtM6HL7dsuqiBptxdr+l1
 aEPWMSbtG2LerED6cLnM7OsXwScbBwKd0K8+A1dFf6mFfb6+ZR8/9BVJDG6fDF5OvSNdnqaEkj+
 1iEMV34DZDufzJaX3Iu7qO/HhGdVzcT4MgK+f02l5i2L75qtDtm9woCJUoKFbAuXqSstHmNrC7h
 WVLKP8u2t10QbRxJYPjHNSt/1Ch8hP6ocYFvxlyFVNDHVfZuc4zhZ6F9Hs1koFmurjLUE49o0s7
 nFIgXht0RgXnS1RiQ5A==
X-Proofpoint-GUID: j5yrQEtjJSqM1ByVFyaazDVyJsWJfSva
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605250109
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-10859-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,gmail.com,gondor.apana.org.au,davemloft.net,kernel.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 27FD65C957C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 25, 2026 at 03:39:17PM +0530, Kuldeep Singh wrote:
> >>> These two entries are logically the same (SID & ~mask) as the first two,
> >>> does it still work if you remove them?
> >>
> >> Yes, resulting sid is same for 84/94 and 86/92.
> >> Basically, the resulting sid could be same, it's an optimization which
> >> smmu is doing which can result in same SMR(Stream matching register)
> >> routing 2 different sid to same context bank.
> >> So, 2 sid can be used even though resulting sid remains same.
> >>
> >> Also, DT usually dictates what hw capabilities are supported and hence,
> >> captured all apps entries here to match the hardware description.
> >>
> >> I hope this answers your query.
> > 
> > It doesn't. Can we drop them?
> 
> Could you please explain more on what's missing?

Usually we don't have duplciate SIDs in DT. Why is it not the case for
this device?

-- 
With best wishes
Dmitry

