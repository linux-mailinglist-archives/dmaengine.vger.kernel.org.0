Return-Path: <dmaengine+bounces-10162-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOZcGk9M8Gm2RQEAu9opvQ
	(envelope-from <dmaengine+bounces-10162-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 28 Apr 2026 07:57:35 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEB647DCD4
	for <lists+dmaengine@lfdr.de>; Tue, 28 Apr 2026 07:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97A4D3028EDB
	for <lists+dmaengine@lfdr.de>; Tue, 28 Apr 2026 05:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451F529C33F;
	Tue, 28 Apr 2026 05:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JJF1NJGO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XdxHiT8I"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B1430BBB8
	for <dmaengine@vger.kernel.org>; Tue, 28 Apr 2026 05:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777355828; cv=none; b=nsr6WZBUIxn/QL8Wbqa3fPcs51OkBPf3EVMKcmi7Dh1Vnh/rZ3EVpt2gztylNLds96pbo5JeYdAeeGL+ElJ7Vo8fYLEy3XYWyL1X8I/1qDxv0csqxBkt3DvM6sBe7mUxhMZO+4kYwMp8RVw/dp+G33dbavLGrcClBJ57nw6SDn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777355828; c=relaxed/simple;
	bh=LcsFCgCP4R6KBEGDNcumdoG43Kb4ysX4yrxLJAHaZio=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j9cdHAtFU3YRquamaNG/cd1FOmOGU2MlVKi/i8togoV+1JxyNB8rn8D/fVaE6YSSkcVxD5jw2caNXXOpQ26U1osEAulmSNikxX6dl76/OOht/2WCQbP5TYFOoLbCNA/C/PZJT+fCzAC0bDk5EpBvLqYyyQpYnBvrS5AByJGu8p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JJF1NJGO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XdxHiT8I; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S4nGkp2006215
	for <dmaengine@vger.kernel.org>; Tue, 28 Apr 2026 05:57:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cMT9onZy7Wk6dCOLu4+Qo0WwTxabZn/BHLlu2ijHpt0=; b=JJF1NJGOIZBXJ1x7
	wMrICmNnwrmaDKkH0DxKiYTvU3ZPMWfLg2j/6qzFj9PHO6tX68lIsh3iBJM9EpeK
	XMMMrj4PfRMWWjWmdOlrkGB18xpfDIGYs6BlUfkBYOKtL6txOI0t0PF8TFO/Jjpv
	9tSO8LGZk9ZZwRyOme2dsdHJPgHlCA9f14PKICtwVcRhrQx1bBzOrN1rChq868HC
	peWkzm9oPhKuiyHXcyhcEsTRrnXf8UDAa9tMLCmIUovIcYH0uXuc+BeERKHlK6fo
	5E/WDMCbsAjTR7w0Nr2HGLdKgGTt2whSd4Hg+zMHz2oaU1FztxcGk1my6sIgiWrc
	f5tx3g==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt7gkkju3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Tue, 28 Apr 2026 05:57:05 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c79943d2fbfso3232447a12.1
        for <dmaengine@vger.kernel.org>; Mon, 27 Apr 2026 22:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777355825; x=1777960625; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cMT9onZy7Wk6dCOLu4+Qo0WwTxabZn/BHLlu2ijHpt0=;
        b=XdxHiT8InWj38CItMBP6diaHKKIOAM9FTNz6DpUsPS9m3zCgPZsLm6bnCMRLN3kzQr
         +4SBpREM49jZQviLao0sWFLwrsTOuvoqJ4xUp+bQbPyE3RQAs+idFnu4jQ78lqL5WSfj
         lSDz9uTfC6lVNb7TPAERm5FiZVYQRiFI+yDD/lo0w+25qBb9/LlvdTcIvollwTysz/LS
         Ow3S4E8azIxnekaa0s/AlR9CSJGenUwonc2yH+b0fkGN9P9e6r/FUHvCOo3vBcbeuvJi
         AG4QFtmSB8pnM5Vq9Wbm2ULfUWj17Ch5apCbG0Buv6a8hHvJAM0PyQ0S/wZ2w1uwFFzn
         /H0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777355825; x=1777960625;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cMT9onZy7Wk6dCOLu4+Qo0WwTxabZn/BHLlu2ijHpt0=;
        b=FDXpopI8LsC8J6S9lV2xz5PdDYZcq2plVXxRzlWpfWijZQ7QxMrEsBYHBl6CURKsPt
         9CmMjXSmcq8e7nksCnIfjlBh2uFWkXUNc9lcmvOby+5igqYi23Ywq58o8sb4UqtS0nOl
         XOrusDT/i1WMLVGopIyIbd4iw/zpKz1UecD3TF3H81XcBy8fws6iAjvFx/sruNOUL0Zd
         g2+81ATWTDj+HLb4j05SGwceXmZDpXvwdg2bOsd0i67YRH0wr6+nZbmfHU2pHNA3UVBC
         IHF60qTlcsNChusSIv/XYPq0EqnrxBGzTImN7oYy66km3sYqVfmNnZqYGVOJkBNBURWb
         a+Vg==
X-Forwarded-Encrypted: i=1; AFNElJ8yBu98GFdhSk1P7rkfD5G3WPTorKwfghhclnPgQ46tzUrv2uFp7FkwQvxilwyuswNZO5xvDMiHyA0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvSD4WvEgAEKUqkKX6WWVoy6jyJq4Z4Hg84m4vSaj1IdzBeazO
	HR8gcOq+oE4wDxXOZD3JNE6eNseG9uW44nBtB3D0ntw5up0G630DDabjIc2IYj94UMzxvBDaLZV
	yUOe5xwdSUEcmZXuf9cYW5Da0+lfTYxC0h2gT0PPUzx2/W80dwqQJ4wK//x2XVmA=
X-Gm-Gg: AeBDieti2UV5MKZWDCyL7se8afkQCplXTgOirrBkB8FTpsCZmZSyRr+NY6WjwdIGCLq
	ozxTG0UbreDNxu+f/RBANzN70p1nTpV1WltoBVyoaMKlcquVoblLHkHsDBPd86ruQ+p6Gt98ExU
	5OfxCiXpwuidXVZuqqJs53yti+UOkYIIeIC9mbIiY3EdsqyNeI0/Ww/mlnlPjdSHjG1TyVEOihc
	lmSWA/JbPhV4aNHYl3iKOOeMYysrmf3d6nxtt015MdVvZLo2gJSI2ozuzn5MDgCwjBr3KVJ3AAn
	5rWq+jg4CBWnqh+4GYTTDroCIJLSd2kyvnHG2aocLySrVZOSGur2tpvKsoA2Rlbi0sSfKcjWC/0
	n2dx4SCpty2a4xn3P2a4QPQOxaI9jNlhtl6XojRuM7u2k2y2h8fTYBK7LkAVVIdA=
X-Received: by 2002:a05:6a00:4f8b:b0:82f:8332:492d with SMTP id d2e1a72fcca58-834dda8c564mr1904140b3a.2.1777355825012;
        Mon, 27 Apr 2026 22:57:05 -0700 (PDT)
X-Received: by 2002:a05:6a00:4f8b:b0:82f:8332:492d with SMTP id d2e1a72fcca58-834dda8c564mr1904096b3a.2.1777355824524;
        Mon, 27 Apr 2026 22:57:04 -0700 (PDT)
Received: from [10.218.21.127] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834daf3121esm1295298b3a.38.2026.04.27.22.56.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 22:57:04 -0700 (PDT)
Message-ID: <ccfa913f-4fa5-476f-9a17-32ad2392e532@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 11:26:58 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: dma: qcom: bam-dma: Add support for
 kaanapali BAM v2.0.0
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Harshal Dev <harshal.dev@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260424-knp_qce-v1-0-813e18f8f355@oss.qualcomm.com>
 <20260424-knp_qce-v1-1-813e18f8f355@oss.qualcomm.com>
 <20260425-handsome-papaya-porcupine-d42df7@quoll>
 <e00eb12b-e8ad-4db3-b4f3-c8a81f6a081b@oss.qualcomm.com>
 <2d79d1b6-be1f-45ad-b673-c8b3b57f1e15@kernel.org>
Content-Language: en-US
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
In-Reply-To: <2d79d1b6-be1f-45ad-b673-c8b3b57f1e15@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: I_A8rJ84VZnKsWM12eAIll88vhmYiHp_
X-Proofpoint-ORIG-GUID: I_A8rJ84VZnKsWM12eAIll88vhmYiHp_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDA1MiBTYWx0ZWRfX7O/U3ed40jKj
 Xtb0ER5FcPM78PTH7AKbDTpInAyBAlfC8wX3uea6Q9CeAEtlFhNQ8xZlILWLc5Edk5hhvk6pRd6
 On8lUF1rmCyNyS8amaXVerbKmYZDmztn9SnzNf9J62bOx0vRJGZhPZ3mX3KOS98JAKLiRtenlZ8
 pYvMLvjUjJy7foXizYR4Im/9MKHSG4uYoFairXMVt/eGLF7KtsscDf71zi/X54lnUfC1gAeT4lE
 pnyYg9gxdfPgYt1pvvo/DGK2LuFpzmkXhVv712DdqbDM7vsDETJcaCRT8kRZk9QHQanlwPpQ+Jv
 oqBEj08W8o0tWuKuNqoF3RmbGpEu/ZPsjy93pwy9IHncNB/g/GT50EhSBXEXeFWMTDWnItm/ls5
 FO47QFfc0WNLqEi8Dx1gr88GvupIEzlZxx0cqZtbM6JKZdKcwHZWMB2if0zjovw6nfVkofPzZSz
 T5oFLRt+mzWbMXMbN/w==
X-Authority-Analysis: v=2.4 cv=bJsm5v+Z c=1 sm=1 tr=0 ts=69f04c31 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=XH5bq4SrENkH0BnSGEgA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 suspectscore=0 malwarescore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280052
X-Rspamd-Queue-Id: BEEB647DCD4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-10162-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuldeep.singh@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

>>> Drop the example, no need for difference in compatible.
>> The current example captures an old instance and doesn't give complete 
>> picture.
>> Example, doesn't specify iommus, qcom,controlled-remotely etc. whereas 
>> recent ones don't specify clocks and reg address/size cells are 2 not 1.
> 
> That's fine then and should be mentioned in the commit msg.
Sure, thanks for both feedbacks.
Will improve commit message and repost again.

-- 
Regards
Kuldeep


