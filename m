Return-Path: <dmaengine+bounces-6708-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10148B9EC65
	for <lists+dmaengine@lfdr.de>; Thu, 25 Sep 2025 12:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EAC47BBE6A
	for <lists+dmaengine@lfdr.de>; Thu, 25 Sep 2025 10:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EA82F617E;
	Thu, 25 Sep 2025 10:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jBbXJq9A"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923382F6570
	for <dmaengine@vger.kernel.org>; Thu, 25 Sep 2025 10:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758796828; cv=none; b=HCY2cu/hQytNsPx0rnXLJtkxlBFuA0whQmzy/4KUV+cN8GyLKzLYKmyaMoCy+qjTiFwCPQRYDkDoe7Ni1iLIZxCbTxMVpUPYPPbctHjokViGoWU/rImVACy5QJW5NrVOxj2G2wkyV9cK+GJAINO4R/l5ChoDjc5jVqki+Yz78Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758796828; c=relaxed/simple;
	bh=7K0kybRI4HZ4jK8C4ZbdHxQtenjrPucHPMRAKKj6/ls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XoRrhDECmeOYomq73e8wXGHX95wTlznE32w7d7upsqg4Mdwez4PyBMfdNI/ohymEaouMzntbZPKddt4oO5Gwcw87TOSXOAaoi6LfxoxwL8Pwy0DJ1o6YIhpnktq3VxVP5bnJ2yRJs7pHuUQF6UQfoFL7zHpRvw9XpmOhLPe2LPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jBbXJq9A; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58P4aTqJ027679
	for <dmaengine@vger.kernel.org>; Thu, 25 Sep 2025 10:40:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hkrub1vjfp8/J5x0I8lwP41qVsopVVAqErZdeoHT7KY=; b=jBbXJq9A8X3vT/px
	p8Yol/YmZPOKUckMtoJP3NoRKnA0SzIlKkDdBGUkgXDwwvhNg5ZgkbFy+z9HL3ev
	vahRVXNh+BSY8B31EZcZE8062mRi1JFj+x/fqEG1ETpw/SXlIYGxq89XGnVEXley
	YeCKN3zQMl67ONHAjkXYHBeQgsmzPb3rwjTn4slMZ6nrwlpRJX5sN1dmx+vVl/T7
	/9KO/qy2sDJ3fN1NoPvIx5MsJ5OJhl5Ia1vAOGrBNy8fgPHhcX1yd9Hg9kbnjkQO
	j9yn5wEtN/Yi4SADHGVI6GEq17I6tcxuj0kXO774qQVt4goCQGZxQHs8b6hBCeQm
	YHx0Hw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49cxup104x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Thu, 25 Sep 2025 10:40:25 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3304def7909so896588a91.3
        for <dmaengine@vger.kernel.org>; Thu, 25 Sep 2025 03:40:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758796825; x=1759401625;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hkrub1vjfp8/J5x0I8lwP41qVsopVVAqErZdeoHT7KY=;
        b=wmdu928wfeWoXSqq2Ye3d3BbXUiyPUQtbkyDhJ7VhY0HUv+ylTZWjDWekPOOD6AaJy
         f3Hxjbx+LLzKlQFEa6gMI6LWth3r59Nc0EtDEc9ROaMLq9u/onYKrDoI95cPCFrcJfsE
         +Iw9jKi/+uZYlftLBx3sXqBR2YuGTqHaaeX2waJ0s812MqOUvNZEpYo4YOJzEvOGXkLn
         CQ8eNH1h8x07PDXDPbN7tsbwTDW7cFoosWZJYah36WnUNWjZPk5wEbo7VK9sRwTlAK0X
         9pvMneDotOJKmkCepB7ejCf3InnqkGt+zkB1obfOnFWC7X5cxDZXd4n7qEONY9CcNsnw
         pLeQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3JztDb8/kz36yr4SoR7K49wsFXOSzWhf8bnP+4jOoYjo8alF+/zxig1E/g0zjdKVZTX3zmMrB+s4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZRbar4AJRZMVPtoH7rqo5gncaB9SVsDQ+LmIABovYej+E3+GD
	KN481wgWw5VHvS69QzyaVRuGk1K+uTKcKPQGDOwoXTsAemHPCyOUWYo6VqAchnZeWjwJjlRNPEn
	rl+q8xiYiNwh7l2u23Xud9idSmTtQuTC/RuVfKHbyGvUE2fSGaQTTUzCE749jb/A=
X-Gm-Gg: ASbGncuhjiUvLTnHMymNDA3oMs4OaUSYKV7a+m+Hdap4v5FdBaXSnCcf5Y5GT/FiY98
	59ngv0jEOCB47VWgP4MPgxWatdSSRCbdW5PX7FxWx9ygWB7+kXn78i23FqaLwglU2h1vi+A8GmO
	u35kVhStJkzeNF7uHz85eL17iJwCJvAyeRn8dPiA3hLq0HrzLu1tHUd4j7DO1rVFnH2v+e7HGgu
	kDp7SKLIGsasobSS63DY9QuhHwFmMfC49DNtPO6+1EUO15K+foM0ef7XfCg3tCLGNj+lOlKFxID
	IR+qtpRs+hWdNgR6xAUuRWE3oiH8qZyQ3v+yI4vskTFf9+kp3xKpL6kXdLmioKOxj2V1tfke0i8
	=
X-Received: by 2002:a17:90b:1d82:b0:32b:9774:d340 with SMTP id 98e67ed59e1d1-3342a2c66cemr3725549a91.33.1758796824588;
        Thu, 25 Sep 2025 03:40:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGA+HMhVlFvkRg4P3UZGYiYtHq2iFZKBbWgE6XeeuHnOxopWausReC6LBLc/123h2UNoU/UQ==
X-Received: by 2002:a17:90b:1d82:b0:32b:9774:d340 with SMTP id 98e67ed59e1d1-3342a2c66cemr3725523a91.33.1758796824131;
        Thu, 25 Sep 2025 03:40:24 -0700 (PDT)
Received: from [10.217.219.207] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341be2073dsm5353299a91.19.2025.09.25.03.40.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 03:40:23 -0700 (PDT)
Message-ID: <41adeb71-f68f-4f50-a85f-5c7dfb5d587a@oss.qualcomm.com>
Date: Thu, 25 Sep 2025 16:10:19 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 RESEND 0/2] i2c: i2c-qcom-geni: Add Block event
 interrupt support
To: Andi Shyti <andi.shyti@kernel.org>,
        Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
Cc: Vinod Koul <vkoul@kernel.org>,
        Viken Dadhaniya
 <quic_vdadhani@quicinc.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, quic_vtanuku@quicinc.com
References: <20250923073752.1425802-1-quic_jseerapu@quicinc.com>
 <eobfxgtssuiom2cuc2zlsvc2hhyi2jk7qb7zydgo4k5wwvxjlz@nksb3x6p5ums>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <eobfxgtssuiom2cuc2zlsvc2hhyi2jk7qb7zydgo4k5wwvxjlz@nksb3x6p5ums>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=B4a50PtM c=1 sm=1 tr=0 ts=68d51c19 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=GtlKhm42p6TeGv8Q4b4A:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDA0MiBTYWx0ZWRfX8VQfad9BWYA6
 jADvwt205TnMmM/OW+s8zs8Umj6f9R7KXUwuOVkDXvzQXcZAS2SuHBJMAZAzoBmFhCc5b3V2ysB
 3MpBDFOPZqks73OEQGJBl1SdpD5vQCTSWoRLO/2RsQ3JmMBPex1DHJG/RWaoLr3YgmDMxew16rV
 6Tc1DxiqY5jxjkeXcj+lMIoTam/n+qkV7Zm3n8QW0sYRnHLv3vQRptethHIMCu9xfrW/VP9m07/
 b04ubbxQ965FlOzY+DLWIz0dA7OvCn8mEnzJbKGB3fmab8SzLk6B//kwcghRxPBz/O5UsOugPIG
 Jxf+ECxWM8iO1wYUu/NislBVfatf1no8l3U2bGNAG2jwIf5icdUM0958FEZJVSNd1B7+r/Kkj5r
 hLwJaSHL
X-Proofpoint-GUID: CjxkkJOSvaImUw2OMh_LsYhd0JUR-gK5
X-Proofpoint-ORIG-GUID: CjxkkJOSvaImUw2OMh_LsYhd0JUR-gK5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 phishscore=0 clxscore=1011 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509250042



On 9/25/2025 4:58 AM, Andi Shyti wrote:
> Hi Jyothi,
> 
> I'm sorry, but this is not a resend, but this is a v8. Other
> than:
> 
> 1. commit log in patch 1: removed duplicate sentence
> 2. use proper types when calling geni_i2c_gpi_unmap() inside
>     geni_i2c_gpi_multi_desc_unmap()
> 
> is there anything else?
> 
> Please, next increase the version even for tiny changes.
> 
>> Jyothi Kumar Seerapu (2):
>>    dmaengine: qcom: gpi: Add GPI Block event interrupt support
> 
> We still need Vinod's comments here...
> 
>>    i2c: i2c-qcom-geni: Add Block event interrupt support
> 
> ... and Mukesh and Viken's ack here.
> 

Sure, I shall Ack it once your comments are addressed.

> Thanks,
> Andi


