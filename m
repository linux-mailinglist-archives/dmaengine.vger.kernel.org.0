Return-Path: <dmaengine+bounces-10857-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JtXEH8fFGpGKAcAu9opvQ
	(envelope-from <dmaengine+bounces-10857-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 12:07:59 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC44B5C8FCC
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 12:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 980573013B7E
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 10:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9491933F5AF;
	Mon, 25 May 2026 10:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lQnqLCOr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ScFE23yq"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACAB33D515
	for <dmaengine@vger.kernel.org>; Mon, 25 May 2026 10:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779703676; cv=none; b=EuxcpcX7bpxpH7ip5hyiXZg81ZwE38Aqno1YwvjY2jRo4VFYCXPVC4QZhSNl5TBcsGy6nboSQrqg7CIglCHVWy94lW3Pm/udsnjLLqzk+lUThbSDTivzUovenKrfD+6ZQw1v3ggKTdv2Fi5Pe9YQqQBpHDAaveLouyaIvpz7xLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779703676; c=relaxed/simple;
	bh=C3g4fxks9SmnMRj43w1wfWVJ4Dh05/1dM/KR9FJFCqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BsHj7kuKJA07WIr1ZcgI9D8DsqQbKyRKq6VIwjyA+dR5doEuGuqr8PXyon/JWI2E9bnmTsnRxqpPk0F4O/mthRo3k85HjpZY7kdknKkXQhNO5QKlB0fmO8s59ATuRB7FnZnmYB6lR/ReCww4vI/BLmyH+h0g0v1tdeRQSSi/pUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lQnqLCOr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ScFE23yq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64P9EK6r079206
	for <dmaengine@vger.kernel.org>; Mon, 25 May 2026 10:07:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=npNFy+BddQwkGqnWIggATa6Y
	uIGeM/79vARuw8eKHho=; b=lQnqLCOrD0pBVG3BWyTJuaaTU9HTVllJFh6PdSii
	cxLosfITIfApIngBzIFdEUkZSFOx2sAH6UD0JMyrCwz300REDF1HGaZWLdVZWl9d
	s3OEli/A+vs/UNnxe6QYs5GOs/8WMFcB/cdUXYXZggiz0fYCZTy7PA4rHyJSgW7E
	Hqi8N1TADjNGelsI0kbK9EwjZrnFfvvjPqSB32nAku3rr3M1HI2llzcUTvpLKykZ
	jNqFVHPZkmGMeC4yZrIIQFhUjrAkO4Piq+ypCV3dC5yBeegTZV5PVzSbQPHSkxtA
	hFQcfeltv366lR2SmiIKgNO/2D6hrnyUF6lITnatsFcjUA==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eckma870j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 25 May 2026 10:07:54 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-575252f9c56so7328537e0c.3
        for <dmaengine@vger.kernel.org>; Mon, 25 May 2026 03:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779703673; x=1780308473; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=npNFy+BddQwkGqnWIggATa6YuIGeM/79vARuw8eKHho=;
        b=ScFE23yqQerOUhZMyORJbr0UU+aCeyJwKsoueEIPiqAlU6Oa9FDYlwqubPabo2a29V
         2+LbQ4GZNdgQhU2KWEE/i2dfRd7We6N70DL0vR6tWzr4YYfq9hGsbUucuPMs1Z6N483i
         gq69sDjfAzlSLBP+ErmvukGBLOzng3XWQtDWrzaQvonZJsuhFB/BSX6tG0rOnzxKroWq
         Dcf01qHW+hvys6QnDM1Nww4mh9xF0wzqkXAN4LiRe5QrlW/gqb+TeLXK97Si157jiGdd
         LxYjRfwYJQI6f8jOZvJJAGK+w1uAZcM8Q+zq8U7J9wx/QwMSC/vvyZCAmwf11idF0uew
         jEBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779703673; x=1780308473;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=npNFy+BddQwkGqnWIggATa6YuIGeM/79vARuw8eKHho=;
        b=RcUDlnOO457R89ic1/ZUapYCELafJQ/rrrrpX9kdGs/rIgpJSPNSnlHMTUFFDbbHX5
         VdS0yeaV3ycuE38/74+5FkTlvB8hyhLPyCSea3H/FpPj8AjVQJaPyjoLZWvx7VVnxPAx
         llwOwZNaz10qEFLY62ioaJDeX28HOq4Q5V1WA/Ez6LpqBpMzrUpAIhrebaWWC2Ad7CNW
         VPzGasIjXjt7CC4bUSKKWww+MLUrdu1tMwoYmBn9ojdK1LBzfYCWA7sI3UszeBp6R8yl
         Ta96cxl43yZjpc8A8CnP46nhapckxPo8igkqDl7dnqPVDMBTc5G4OVEuC1FmDVc7HV+G
         FuuQ==
X-Forwarded-Encrypted: i=1; AFNElJ9xWxx/0OvU3sHefIowi3VZCYE/P43YnX/GMtk4UB1r6CA+nvVxam7rESLC38bWKcG/ptEuSDGgi/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT6fo3SpHPMhlFA4aM2wGUbSavkDaBXWVFlaGS7NDt24u3EJ7F
	tm0GFuPknnjo/w9GOK4pmTlK46/0vHjEF5e88vsMRfbWgU6YId4OxgqRGjurq5pGvafNll+hw4w
	NOoQpzhlwv5zCz+sEs40JSloxWRcsb5v2T2hMfPpCy0jGDbkLh/aPrUzW3fXGxdA=
X-Gm-Gg: Acq92OGwyZjyNs+tQtKkylWQo53Mh4RHoc/kvsZvnWQ8j1st/yenUdEln/3OU8IAEzc
	Ewhhf5Sbk8pLCgN3AvBMn+s7+syyIeCLT6FTOeHYsmZ8nznxCWwWU/eCdGm4iIi422s1uhusEWc
	VGUXVr4E4JRivocWFF3HTFbFPWS2+F1ESHqp0VWMq+k/3X5GKeUYY4W2ytAQPf/Et0PcxWTsDzJ
	zTNHETzShdyUYGAcZwJE0Ux/uTt3NGcxP1eiP+zeMt8BafQyOILDuAbH+ot1ACZuBkaf96KqHBf
	sbz3A9MGxWLvF3XcYecYAo8fE9Y9ymIhxxef6Ls5Zcg7w/0V3cpYTWNh4pjSEZ/OdpBmD9+kJRL
	qgLt8xOUdzd2hyYpiKhZZVbn+KB9bx2kAJu7Er9ocVe5ifrD0A7RHN4vGqoKz/CxdAJo9HS9OW8
	4kElqpFoeIKdbQL7tjEUi/Fdz0OmSVJQ3DNBk=
X-Received: by 2002:a05:6102:fa5:b0:633:bc46:c20a with SMTP id ada2fe7eead31-67c84adf950mr6349158137.31.1779703673200;
        Mon, 25 May 2026 03:07:53 -0700 (PDT)
X-Received: by 2002:a05:6102:fa5:b0:633:bc46:c20a with SMTP id ada2fe7eead31-67c84adf950mr6349144137.31.1779703672773;
        Mon, 25 May 2026 03:07:52 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa32cb3839sm2565647e87.12.2026.05.25.03.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 03:07:51 -0700 (PDT)
Date: Mon, 25 May 2026 13:07:49 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
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
Subject: Re: [PATCH 0/3] Add support for qcrypto on shikra
Message-ID: <s5u3vlc3r2blg5hniwuqizazooldebr42n7hr2f4jw2ybbq3oe@cdmrv2etrmj2>
References: <20260515-shikra_qcrypto-v1-0-80f07b345c29@oss.qualcomm.com>
 <20260514194735.GA1939213@google.com>
 <d4d35e17-84fa-4c95-9bfb-abfd25ea7f4a@oss.qualcomm.com>
 <20260522024912.GC5937@quark>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522024912.GC5937@quark>
X-Authority-Analysis: v=2.4 cv=cL3QdFeN c=1 sm=1 tr=0 ts=6a141f7a cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=pYtsz_S_oP7Wd7TLaGoA:9 a=CjuIK1q_8ugA:10
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-ORIG-GUID: UoRK4l4uQEaruojbaLUVE7c0XLSp5kso
X-Proofpoint-GUID: UoRK4l4uQEaruojbaLUVE7c0XLSp5kso
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDEwMyBTYWx0ZWRfX/LtZmd8U9lwr
 EiFTfojusaYV6g6wKBYaekaBIMxuB60+ADuM16e4pbHfXrnfzeDfs7xcyOt2j5pKBbeZIh7QNhM
 dRATX9p0DzlvB5hDVZmyGVXgCkrR/jrKgx1BQ9vRudXjjVp9Rsbiv0oTYyWvljbCQaXU+RDc14w
 ap59fVUO7afwLjK8sBFcy8poTNesP8njIlcebHUG81GuhTEyxaPcwH+G8z5Tl/g0qVHlnRzSmvm
 HH9zLdNlHn+neCCLZUQotOA8ZzzIW9ggI9zwlhldX6iTZxiN+RV7+Xb+7p8GW8DOEPyISzouvs7
 kD/zG5XwQuGdtuUkkJ/ICk+7FgjFsLw/qyQNyKtBRFUgUaR8xor1jHpq8EBbya7i/eWRnjnSVx0
 K6pq2UqYeltw0pswhCJ4jx03rp9YB9x7di9eldyKo8aae7bqbC9II91NK73mwUc191Xu5jJ87i7
 oirA2SquOmmWm5P+sHA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605250103
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-10857-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: AC44B5C8FCC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 09:49:12PM -0500, Eric Biggers wrote:
> On Thu, May 21, 2026 at 12:21:41PM +0530, Kuldeep Singh wrote:
> > On 15-05-2026 01:17, Eric Biggers wrote:
> > > On Fri, May 15, 2026 at 12:53:35AM +0530, Kuldeep Singh wrote:
> > >> Add qcrypto and cryptobam DT nodes for enabling qcrypto on kaanapali.
> > >> Shikra bam dma supports 7 iommus so update dt-bindings accordingly.
> > >>
> > >> The patchset depends on below. There's recursive dependency so referred
> > >> to base DT patch here.
> > >> - https://lore.kernel.org/all/20260512-shikra-dt-v1-0-716438330dd0@oss.qualcomm.com/
> > >>
> > >> Validations:
> > >> - make ARCH=arm64 DT_CHECKER_FLAGS=-m DT_SCHEMA_FILES=Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml dt_binding_check
> > >> - make ARCH=arm64 qcom/shikra-cqs-evk.dtb CHECK_DTBS=1 DT_SCHEMA_FILES=Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
> > >> - cryptobam and crypto driver probe
> > >> - kcapi test
> > >>
> > >> Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
> > > 
> > > What specific kernel features would this be useful for, and what
> > > specific performance improvements are you seeing with those features?
> > 
> > I hope you mean 7 iommu entries.
> > 
> > Please note, shikra is an old platform and differs with latest platforms
> > like kaanapali in terms of iommus#.
> > Kaanapali is optimised(in terms of iommus#) as same pipe index/sid i.e
> > 4/5 can be used for general purpose or for any other usecase like
> > DRM/HDCP etc.
> > Whereas for shikra, there's dedicated iommu entry for each usecase and
> > same pipe index/sid cannot be used for other usecases.
> > 
> > The performance will be be effectively similar.
> 
> It sounds like you don't actually have an answer to my questions, then.
> 
> Performance tests (e.g.
> https://lore.kernel.org/r/20250615031807.GA81869@sol/) have clearly
> shown that this driver is an order of magnitude slower than the CPU.

Are other harware crypto drivers faster or slower than the CPU
implementation? What about the CAAM (sorry, it's just the driver that I
worked with few years ago). Or Xilinx? My guess would be that for the
most of the modern ARM64 hardware the NEON implementation is faster than
the "hw IP" one. My assumtion has always been that we support crypto IP
for the sake of security (i.e. making sure that the key can't be found
in the cleartext in memory dumps or that it's impossible to tamper with
the hash values before singing/verification). From this point of view,
using priorities is expected and logical: most of the users will need a
quickest implementation. Some users will need to use protected keys or
other hw-only features.

Note, I'm not commenting on the driver being buggy. If the issues are
not fixed in a timely manner, it should be marked with 'depends on
BROKEN' and further removed if the issues contine to be non-fixed.

> This driver has historically been quite harmful.  People were using it
> accidentally and encountering very bad performance, as well as bugs such
> as crashes and filesystem hangs.  We fixed that by lowering its
> cra_priority.  But for the same reason, even when enabled on a platform,
> it's not actually used.  Linux would be better without this driver.
> 
> We seem to be seeing the usual drivers/crypto/ pattern here: this crypto
> offload driver is being pushed by the hardware manufacturer, with no
> awareness of the fact that it's actually useless in Linux.
> 
> I've had enough of this.  Please consider this series:
> 
>     Nacked-by: Eric Biggers <ebiggers@kernel.org>
> 
> FWIW: the approaches that are actually used and work well in Linux are
> ICE and the CPU-accelerated crypto.
> 
> - Eric

-- 
With best wishes
Dmitry

