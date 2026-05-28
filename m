Return-Path: <dmaengine+bounces-11005-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAgyOCNIGGr2iQgAu9opvQ
	(envelope-from <dmaengine+bounces-11005-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 15:50:27 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2995F3037
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 15:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3C518301363A
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 13:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E25282F17;
	Thu, 28 May 2026 13:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NgX2AMwD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fdvJp/K5"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92FB277C81
	for <dmaengine@vger.kernel.org>; Thu, 28 May 2026 13:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779976218; cv=none; b=ppMaYJFh5/8oHXCg9p1P+PU0Ff5yCdqK0nlCN7Z4dk6ygEen/8Zrz1167lgahNBqq7z4hIoTyy27Mk6RU9sKOSFtq/y/HC6ForPrjw2skmRHJE/6BWT2eiDGswNjQwSI46gWiJxwVpJr9cpkiAGhNKT3K+P9b/5AJhtajHEGPRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779976218; c=relaxed/simple;
	bh=vd/rQRJQWLIg+xDuYcY88Qbbo0c1bTx1+oaoNovwGyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uAPr7Izw93gmxYBOt+LuKwWBmNJdPOH+m4obPbz46lA13aGvXYdaCMgXjT6gLIJ7M1rnnw6SO7TDgsIfUsTGPGevZ0pQUDtuQ1xK0ChGv6EAtDIU3gYH8xxEQ0IagXnIWSLwUcrUY3BDzfaVfO5DvR3Q3qdcjlcHK40tA28pdv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NgX2AMwD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fdvJp/K5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64S8vlIF298274
	for <dmaengine@vger.kernel.org>; Thu, 28 May 2026 13:50:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=V1s8jKskQG0bDSH4tCE3i2dJ
	j/wDsiGH0s/CmPfjVgE=; b=NgX2AMwDdKD5hgnZ/aYfhZ8QKTSbIG1dhVGw28oC
	JE9VZ9pHC7Q9lp0qBxKGwnbXDagxOHrxzUaHpAS7hXdptOXPGCF4f8m6NQPyW6Z2
	KMjfUFxVH1jCEkCXkKVUaj4KEssFUt1vVfIiUJl2DNaN8YEQT7sFqEuD088Kv8Ft
	uJDIsZXU/ho+KkQKf2lx8e3lO5DUexyPcYZWGsH72h/Aa2tACM2fu8thXVZQYecv
	WE1IY48F8aA9vkYcxFlfa3PFRdXFvyjyO8YLJMueXqkInfP/Xbd6Hgptmp00SJUY
	zda8ERh+f/Z5TjiAA+dduUqaTkg5oqXjdYALwFWwdC1s+Q==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7yajy16-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Thu, 28 May 2026 13:50:15 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-95cfe3d4c16so19347550241.3
        for <dmaengine@vger.kernel.org>; Thu, 28 May 2026 06:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779976215; x=1780581015; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V1s8jKskQG0bDSH4tCE3i2dJj/wDsiGH0s/CmPfjVgE=;
        b=fdvJp/K5Q9X3GiJZCj+oDun76mibiFVvphFV8V7wH/f8dvY4BlIxrzIwgRC31A/Omu
         nhVRXT6LZMoz24Bqt3kzkOoUOdIH2oy44dw3bYxFmvOOmPRJM2LiR1gZPw9oezawVzA/
         g1B0Ovo+yyhP0hMTpa+TCHoUR6+Co18tlwHmtncIFgLtLq0SOOsp0lb20fYMD9PiqW4/
         +iJz7dAUEJ7tbusRiRZaLm1p6cWl715j+c/Gu1gubVLhwih2fVKH8QVkK0HZbANvsOH3
         mfoYH608D8boPTdhksT1p941dyivWSHI+StYMHqTxZm8f0wMdfYYjGQgeMnXnN9YUA5I
         w+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779976215; x=1780581015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V1s8jKskQG0bDSH4tCE3i2dJj/wDsiGH0s/CmPfjVgE=;
        b=Gy+6mHuB5UAZbhhllIuWDrKBA749jrY5QXOM5okcJdiC0bAqPUI37itnXfzcvX7eVz
         9VNc7cCaFN01Yu6gFOOkf3oa0yyQ++NAXMRHqswLFfMjxfYE8e/08K/7dkvtyG9lPt+i
         ZgjTXa28Vv4z3WwmEvi6gkST0371J3ZMiqEccoK7cOG4wRkjG53UGlupGlSPGkumVC0H
         2iDayfkpw1tJWqxm5zwR9L2ADeM28f2PIvM5PKBN14Nji1AuBctoEjTaSs91gfgHEKRU
         xwYbdrqMMjWCODGd0h4A8FLiCIHivpKq92uLlEwuR0cE1c7B98gJpCLBXZUJR8rjBtcD
         U8+w==
X-Forwarded-Encrypted: i=1; AFNElJ8+mCTP+4bZZL/sMu+WrJv6O+6Kt1Qa/dtzBxrpnLNZUChEYdsIcz5tmK40QK16QriYRBaNWG8OItg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq4g+K6ven8x7tTgwry8cB4JwAdvEKH4T/ylzhqNPQHHPyaVHu
	vqYeYX/uqb4oH4vgOtInckb/uUgME7qw/b3PZR+xkwtbxIaTSH8XdUkVaBX66WqUQXrim1bODMB
	+rOl5C/hdraz5l0jJ1cC5Rbaoylvl514mQohnil6pazILh0/51D49OjNU84Hlx2A=
X-Gm-Gg: Acq92OFAj2v7vECAiH3m6e+ce4+iwuoB96RaTjNpj1oCtP3WZx3etA1UdR3orMG8kyE
	eeJLqKdHh6iszBxqwo2RZZxW8TP+ICB6vrtR3D/S+BUaKTC55YN2QcYRiEkrIAkvkr0FSCD1FKZ
	TpTW+hPZfUiwTRc8R+ICpDALYCEJ177AW6GXUOHz33VTzpMB7Uzlf5N4JHQz8TKa3peLQAhyrYb
	ALDnhduLmEIVxtyntO2Vli1vP+jCQjEAyqalL7kuH7noHq2GVVgmivRyJndvLPcPZUyfhwdfr62
	R9DaDCrPtZVyNel+rQmeQAdI+nRBUpql/8IJ/az1d4sg2eIk/5mrycXR8lR9EzVhTd7zLubVOFx
	MAx5JElL7+yaBnqvucjKHI9VB2zOTd6W6HI4mk2IhnPQnGDXIEiQofTNcXecEfqRdJ14DwfzjrW
	RxqSpIHjsGNBjHj7AYs13rwVrU8hkZQg3PbX1NZi4JZsZhug==
X-Received: by 2002:a05:6102:5ccb:b0:632:73ad:6c8 with SMTP id ada2fe7eead31-67c7f273532mr15881164137.7.1779976214957;
        Thu, 28 May 2026 06:50:14 -0700 (PDT)
X-Received: by 2002:a05:6102:5ccb:b0:632:73ad:6c8 with SMTP id ada2fe7eead31-67c7f273532mr15881139137.7.1779976214562;
        Thu, 28 May 2026 06:50:14 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-395dcc45b19sm39183511fa.40.2026.05.28.06.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 06:50:12 -0700 (PDT)
Date: Thu, 28 May 2026 16:50:10 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>
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
        dmaengine@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Gaurav Kashyap <gaurav.kashyap@oss.qualcomm.com>,
        Neeraj Soni <neeraj.soni@oss.qualcomm.com>,
        Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH 0/3] Add support for qcrypto on shikra
Message-ID: <lj7geczhthury476ilkjym2k5fblo5pqroefsbdfgh5jcf7zy2@qrss5xc7umn3>
References: <20260515-shikra_qcrypto-v1-0-80f07b345c29@oss.qualcomm.com>
 <20260514194735.GA1939213@google.com>
 <d4d35e17-84fa-4c95-9bfb-abfd25ea7f4a@oss.qualcomm.com>
 <20260522024912.GC5937@quark>
 <c1697372-54ec-4f57-85d9-ad375ff1a44d@oss.qualcomm.com>
 <20260525142843.GA2018@quark>
 <e49c4a45-6455-47f3-a91f-c32c1a0b99be@oss.qualcomm.com>
 <CAMRc=MfC6CEwOXYttsav3mwqyJ2F4sburBj+zNJ25qMoweyL-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=MfC6CEwOXYttsav3mwqyJ2F4sburBj+zNJ25qMoweyL-Q@mail.gmail.com>
X-Proofpoint-GUID: PdJtXsdhsmUKEjVEcL0jWbLKqOQFoHe7
X-Proofpoint-ORIG-GUID: PdJtXsdhsmUKEjVEcL0jWbLKqOQFoHe7
X-Authority-Analysis: v=2.4 cv=CaE4Irrl c=1 sm=1 tr=0 ts=6a184817 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=7wDE0xjjevibnHHXysgA:9 a=CjuIK1q_8ugA:10 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDEzOCBTYWx0ZWRfX6m7MpzAAasFU
 EksIYvwOK/3sCHE/orScvBCbHq9VUSnQivmoJGi7GpsABgzAh0wH/CTahkSnn/vFYRaRrTsYnXt
 IpwzQ491hzCFUV2ODW5pYSJ9a4S5PADkHngLIQVs7HPsy+jXxjXZWGCq+UfL70jRNdrrFIFYTYP
 kvN2GzYz/XEhZoan1zxZThvsuZeLF8BEk2hthISIid9gYHnjtevcrukISlaDA6vxxvSISZx+g/h
 8AY6bcDZuIyiOlB8DeVavQLyKV7pZR7KB6bLl5RrkpgvP0b6qChHgOGOeSIhGSlHmkuDOyA0rk7
 Jx6Ra+63JLIsl/aktg83jYGNkeHOLzLQv8jQb/5aXuVY926yWGKirU3h8JRK6DgXwy7h2XJflGp
 ZYN5oq1YGT6HTEz2Rt5m2ADf9/fuK4W5xOpe/hrQBCKVjLGF2SBA4FDwr93EUxnOzdgr6E1P+kr
 qs6JdLCj0bi2haoVxNw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280138
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11005-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,gmail.com,gondor.apana.org.au,davemloft.net,kernel.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:dkim];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: CF2995F3037
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 09:13:23AM -0400, Bartosz Golaszewski wrote:
> On Thu, 28 May 2026 13:54:51 +0200, Kuldeep Singh
> <kuldeep.singh@oss.qualcomm.com> said:
> >>> +Bartosz, Gaurav, Neeraj
> 
> I know about the self-tests etc., I will address them next.

My 2c, the self-tests would be more important, as they are fixes. Doing
the crypto in a wrong way is a bad idea...

-- 
With best wishes
Dmitry

