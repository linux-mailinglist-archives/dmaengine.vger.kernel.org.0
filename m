Return-Path: <dmaengine+bounces-11494-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dJUrH+e3K2p2CwQAu9opvQ
	(envelope-from <dmaengine+bounces-11494-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 12 Jun 2026 09:40:23 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 181E7677531
	for <lists+dmaengine@lfdr.de>; Fri, 12 Jun 2026 09:40:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=gIblCZAL;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=MBaHTtl5;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11494-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-11494-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 11F1A301570F
	for <lists+dmaengine@lfdr.de>; Fri, 12 Jun 2026 07:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B034B3A83A8;
	Fri, 12 Jun 2026 07:40:03 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E0637C0EC
	for <dmaengine@vger.kernel.org>; Fri, 12 Jun 2026 07:40:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781250003; cv=none; b=oAhgfrINbluMbeL0zCM0ZV18SF9nIOmXnWy3YPE9mvshd0pAP3KAuu1roEGsP5LPch4iXtKoBAhEMUaTkcR+tqIVTM8hTdkAYY7GZrmPsz9jI0HHfutiEgU/tbOOZeKkcfVrszC2bbDQuTf8n7qrjn52ybAl162Qtr2OuU+h3dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781250003; c=relaxed/simple;
	bh=wRzmweWTsEmfV/ChG/585e8oNfnAo+XKNcaHI3K50VA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hJfiFS2V6+iJP68bZxJEZR7TBmnDRSxsPnSUZvyfgF/SEvMWYQUIQAUQwrnGEL72pbE3ddwQEb3ddz22BAt6l8wvWiXftfm2JsPdgwHgoXTEIMX15DkK8cQPkc+lcBEQNjiOjpAu2OlhU83pO3t6WJuif6GnW+rHfUV0teI//Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gIblCZAL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MBaHTtl5; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65C3BqK92401901
	for <dmaengine@vger.kernel.org>; Fri, 12 Jun 2026 07:40:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=b51pKFTZa41NHWLB6gkRnfII
	61VCO8Fd0ha14432d/A=; b=gIblCZALD/G4JaBW1/GSXqShUWkn4nJV7hLtLYEX
	IO55SvSu8Si0ZZcSBG5j1kJElzgWitQdKTFx4m2aDQaY7zfCIYUySbkv9B3PCRVW
	6wYUPhuAO0xtZO7+CguCFesPRCnMbK2E5upl0egT9ITMHt6XDZZhDF/zBdyP99D8
	+sGbU2ZzW/7q9K9aBoCv4oiwh9/coooN4CdlPWzYU+fD2dS3HoS3bst8NUXrc+P7
	MNT69nK1d559ZLJ8TuWBaW/i38XlJ86Hm+5Cw3sm7i0vxKT9B3QGfboPjeX7ypEC
	j4aw7LBDVwPDxSgZUne9R7G18CgClEpHGMxBuyn9xEveQQ==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er30ga1k4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Fri, 12 Jun 2026 07:40:01 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-59eba324559so339899e0c.1
        for <dmaengine@vger.kernel.org>; Fri, 12 Jun 2026 00:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781250000; x=1781854800; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b51pKFTZa41NHWLB6gkRnfII61VCO8Fd0ha14432d/A=;
        b=MBaHTtl5O0pOG8wvz5+9b0vy+jMFr8Nb+XH+EQV7aw/+30abU0j3Of3mJ7ovyxqg8I
         VK46wCK/tdPeWkGM6JQq+AgDE5GdUe/IuGXjQesBTZs0ldA5FiZzJWijlq+fGVyZikWb
         FcbBau0J++HuctlH7tR7KNZELx5Qz9UBDZn09sgp5ImpQ4jL3XTp2FHdf6HaPjh/oQv6
         so5m+BycWWjyY675nmwHsnf50gCdxKRw69zzFLkf5Ps5wHaH1A6M0UMq7qw1Waw5FqbQ
         oRVmxdAqdRi5zR20yFN8vkcM9HgBs9DY7i0Y4NE48B/zyk8MWji8SEX8bCkreV8c5i2d
         dYlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781250000; x=1781854800;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b51pKFTZa41NHWLB6gkRnfII61VCO8Fd0ha14432d/A=;
        b=r0keILROQ3dwLt+VoZ4JQhG3916d0orgTaQY9qwrty7Bt3q0i6xCgPYONcKLx1zo+K
         4vLSQ6T5JJyg/ipuZU0+Rvj53TKq4RV0af1lilSAtSYHyal889NbGFUTVXjrU7eUNWY1
         oVg+/ux856vgzyoD9+78frUZWKSyQkAJDVBMRAZH3l3cqKWbjPtdQaI9hq1/TpR7IMCK
         rN27U2WuOvK41I5uiiTgh5MMJimsy33HdznbcREUKrpdmKqG75703O1E/raS4bIB0jki
         QKCxu0nVhH+1BgsWaCrw5dOR34moIb53RqAj+Px/LWsUfez5IcGSmhPdZnc/XLeYbneU
         UHiQ==
X-Forwarded-Encrypted: i=1; AFNElJ9QZ2RgYnKJ2/BhbAYbQUpPJiBln1jfqiZ8A/z9Sgj2wZfV3MlxUNmz4yY72oVUQTIeofVSfhObBrc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxli7zMTz8dPCIsZGYHwKntTM0T7STH6m8wIXLZUlh3mWdrxdEG
	zorJaepF0yp3OV2tiUM1/djbdGIrkALoOmdsOZN8qwvIo8zQei8d9UL44IrUA0Mh3cBFIk6nl0b
	Uo4oWyM5lc6DY/3IidzbqLcXc9oQknIMZhFR0dF3bkF3MW+ts48o2jqINB39ncRk=
X-Gm-Gg: Acq92OF3gD+o3FHjsvqHXyO93tEQPqy5JZl03lGM0n9/nxQ5b34wB50WD4mAtt2n4EW
	otvpBTBEaAWdX+wGnVg31TWWKARPjeIwgynfV9UCbCRoe+FxMd8h/zWeTJ4AMftI2pXlHWjZ9uf
	cR1Ia5L5KVetoyvkZpIzbGV/9C4QXrERNJLS2cRPiWLJLzebKhnGJc3kEenm0ScdYSoz0/iVnj4
	R5iz9HKflyKj1M2ohBsioXpYpcQjmhSI1v80UENffBfXZJ74gyKeeKlpVuj5azqNkl3wAwRHOrL
	PvmZjzxPYob1wR6SC8XIPSLHTyExSFPQTeuofBX0xoQksO4JSfIaiXyQnfanV/0V3hr5237eGdX
	hFho+jhVll0YuQQX8jjcOUSa8HSHvzq3hzr4GGWWXcXhLMi/FBhMvTlujEk5xCVPWK6EYDJJRk9
	5EexWmsEMWyMFk5aWHCjWjTwpVw+FDcZTIJ0A=
X-Received: by 2002:a05:6102:6a8c:b0:6e0:3d72:3044 with SMTP id ada2fe7eead31-71e88e1fef8mr501068137.28.1781250000571;
        Fri, 12 Jun 2026 00:40:00 -0700 (PDT)
X-Received: by 2002:a05:6102:6a8c:b0:6e0:3d72:3044 with SMTP id ada2fe7eead31-71e88e1fef8mr501065137.28.1781250000130;
        Fri, 12 Jun 2026 00:40:00 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39929f1ac3asm3978701fa.20.2026.06.12.00.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 00:39:58 -0700 (PDT)
Date: Fri, 12 Jun 2026 10:39:55 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: Frank.Li@kernel.org, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        md.alam@oss.qualcomm.com, lakshmi.d@oss.qualcomm.com,
        Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v6] dmaengine: qcom: bam_dma: Fix command element mask
 field for BAM v1.6.0+
Message-ID: <minjqzjpe4t2yh6sf5lih7obw3hvd53dezjvkbzvv4bwdlshti@tpafx6ubgnyb>
References: <20260611045757.2841252-1-varadarajan.narayanan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611045757.2841252-1-varadarajan.narayanan@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDA2OCBTYWx0ZWRfX6xKx8MhhbIA1
 sdWe1Ys+fQoBEuTGVPGVzksgk4jO1cj47fzPAmVipC3OYmn/TZ4NNRGwQKo/vH8IOLuAt3lGcS+
 JJ8X8b+xMmguHBAzyMsgtTSZrwk7Ii8=
X-Proofpoint-GUID: OMLSPzIAWadkngymnrHeLrA-lAVr0D4R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDA2OCBTYWx0ZWRfX46bFwHViHDHp
 H8Ore2NGouFm7YuqX7tfx1Hw7FU9U5iJEy0agYKEHE3eT0e5YhnIgvACM/ehtzvP56xAkewbL+L
 eHlZc+R6IME3BPrpIkcAkhoggJHX8JRaDyCHUB7rsO7eWp1k5dHkiZwvhFSOo+LR7rGPS68kkaj
 KoBjmAeivB9sKc/zMJKg7n0Z9SBkFZDqo4SrfO/wZKtE0783AnBnXGELvwUblSxo3AFWb76wF5j
 +vX7ncY1rfF7PRAXSLEGKvy/QcS+uLZvDztvCS5GNQRhTFszFfETcSSX+r/IuZi0OJgA/wgcFe3
 dNuui+ITxHJVx1ew9VF3wQedMQiuCpgWpFk7T1XZNi7zkvat5re5La+HI8vsx1QuS/cEKF80Xuh
 KKErqWhFHsXps8jB7zINGueFhXrSJ/l9sjXbiHSHnuRQx7jmlTUF8S06CsNnXfUkLOcf79gS2Vk
 XmmoTozWZfZuI8Ruwtg==
X-Authority-Analysis: v=2.4 cv=evnvCIpX c=1 sm=1 tr=0 ts=6a2bb7d1 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=8AirrxEcAAAA:8 a=6DVrzdH86YzCZK8_rrwA:9 a=CjuIK1q_8ugA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-ORIG-GUID: OMLSPzIAWadkngymnrHeLrA-lAVr0D4R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120068
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11494-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:from_mime,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email,tpafx6ubgnyb:mid,nxp.com:email];
	FORGED_RECIPIENTS(0.00)[m:varadarajan.narayanan@oss.qualcomm.com,m:Frank.Li@kernel.org,m:linux-arm-msm@vger.kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:md.alam@oss.qualcomm.com,m:lakshmi.d@oss.qualcomm.com,m:Frank.Li@nxp.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[dmitry.baryshkov@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 181E7677531

On Thu, Jun 11, 2026 at 10:27:57AM +0530, Varadarajan Narayanan wrote:
> From: Md Sadre Alam <md.alam@oss.qualcomm.com>
> 
> BAM version 1.6.0 and later changed the behavior of the mask field in
> command elements for read operations.
> 
> In older BAM versions, or prior implementation assumptions, the mask
> field was effectively ignored for read commands. However, starting from
> BAM v1.6.0, the mask field for read commands is repurposed to carry the
> upper 4 bits of the destination address, enabling support for 36-bit
> addressing. For write commands, the mask field continues to function as
> a traditional write mask.
> 
> The current driver sets mask = 0xffffffff for all command elements.
> While this works for write operations, it breaks read operations on
> BAM v1.6.0+ hardware. In such cases, the hardware interprets the upper
> address bits as 0xf, resulting in an invalid destination address
> (0xf_xxxxxxxx instead of 0x0_xxxxxxxx).
> 
> This leads to failures such as NAND enumeration issues observed on
> platforms like IPQ5424.
> 
> Fix this by assigning the mask field based on command type:
>   - For read commands: set mask = 0 (upper address bits = 0)
>   - For write commands: retain mask = 0xffffffff
> 
> Also update the bam_cmd_element structure documentation to reflect the
> dual purpose of the mask field across BAM versions.
> 
> This ensures correct behavior on BAM v1.6.0+ while maintaining backward
> compatibility with older hardware.
> 
> Fixes: dfebb055f73a2 ("dmaengine: qcom: bam_dma: wrapper functions for command descriptor")
> 
> Tested-by: Lakshmi Sowjanya D <lakshmi.d@oss.qualcomm.com>

No empty lines between the tags. Also missing cc:stable.

With those fixed:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


> Signed-off-by: Md Sadre Alam <md.alam@oss.qualcomm.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
-- 
With best wishes
Dmitry

