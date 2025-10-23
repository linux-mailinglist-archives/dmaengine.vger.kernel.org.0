Return-Path: <dmaengine+bounces-6962-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB76C012D3
	for <lists+dmaengine@lfdr.de>; Thu, 23 Oct 2025 14:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A74603A9425
	for <lists+dmaengine@lfdr.de>; Thu, 23 Oct 2025 12:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31FD313E28;
	Thu, 23 Oct 2025 12:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OSA9QUjA"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2394E2EC568;
	Thu, 23 Oct 2025 12:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761223178; cv=none; b=hvw2kjGzjyFxg/cuRFildcg8/EI1VT7/DTVWgv3ryxKU+tqsCOEnDfmRLWqdYk54AVu2vhSY5bvhJJWcqrAKFC+yAWGcDpr1q9xXZIex34bumuDHHfBOUzIoaXGFzlpz/2R6eU8nTFGzET2bR6E3pHBQBPvp5cEngZYHwRG/1hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761223178; c=relaxed/simple;
	bh=ENxKQGLphv3+AjkiaeUv+Q+GG4Ha2gwwg2AeDWQi4fI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PjaXwO/YRbFEWCcHmtfV0vp+vDIYk/tEFb2cc1SdwIs8jrllcIBY+FQwGjMDbAP9PQJoCAQ+F+zV4QDlVh9hl5DlJrcXs7h0XlxIIzAYSU3bbSFqUL6KVR0rlRvoH5MFgE5wY5O5UzyFBX80p1CpFRIvwRrOXD/7X+coxoC9ZxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OSA9QUjA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N6iTve026532;
	Thu, 23 Oct 2025 12:39:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	em6T5/MuXjt9/C6nu7UQlOYK72gnLBq+vLNDjIAMRLw=; b=OSA9QUjAdqhznGUR
	9sawIXXfIyWZtMDXKUdup4GyHzaGvhGiiI71kurOW0c1vM+CBoOifN5SdzXKyTF5
	rloc66kBEfsC27bM4/bnO2pR+A7Bcb5ov+1K1mlO5iAShWk9pLJNET2QLR2ux3Jo
	FYyjKNmfym7DpntkMNyBKrNlmJKCu3dW87lhQbx6KSF6wj5tfNGmqIQlnsFKQwp3
	6dShfLOqhvyKoNSen+J4n+ho+PrG/PLs9E3OJnuYwITlNJWQyMojS2PX7qtYh/wT
	gqFnmZqSUesUze5uQ7+T71T3ig7g/2T5UT5zK9L3/E/MngVmFSzCDlr9pMW9Yifk
	9XSNEQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v42kg7gm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Oct 2025 12:39:34 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 59NCdXU5025137
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Oct 2025 12:39:33 GMT
Received: from [10.151.36.184] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.24; Thu, 23 Oct
 2025 05:39:30 -0700
Message-ID: <7b790b0f-9dc0-7177-836c-bbb1a342068b@quicinc.com>
Date: Thu, 23 Oct 2025 18:09:27 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 1/9] spi: dt-bindings: spi-qpic-snand: Add IPQ5424
 compatible
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
CC: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <andersson@kernel.org>, <konradybcio@kernel.org>, <vkoul@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <quic_varada@quicinc.com>
References: <20251014110534.480518-1-quic_mdalam@quicinc.com>
 <20251014110534.480518-2-quic_mdalam@quicinc.com>
 <dd1e4289-5e36-4b24-9afd-f09569459a96@sirena.org.uk>
 <96ae7d38-4ce0-fa34-e6f0-6bb6e4ceaa28@quicinc.com>
 <0a743099-face-4cc1-91ef-098a748604b7@sirena.org.uk>
From: Md Sadre Alam <quic_mdalam@quicinc.com>
In-Reply-To: <0a743099-face-4cc1-91ef-098a748604b7@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: WeLjqZzViYgfKw1VB0ES-yIzBLHsKPkO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAzMSBTYWx0ZWRfXwZWPk89gUPef
 KI/vSal51wnKsXAzh6moK4dlqc8Gy8kHTi55T3f5omPFrqjor8MacS7+hg4itSoTFJUmcEomKgb
 ELgweIW9b5g1MdHXBWJnuLrcd7ztf5f4aBLKlIfB3qn5psWkSjvG8XzhEUyRj23VuViGsI72jRy
 lpJ4pkTKGqU9ovKTdXBApUTJiXEFonYFfE9x0gnzRlJzR/Y6NMv2dz16BQviYILENU73wrf4u+N
 XdU29Pl7E8Y0D/OwTRRqHF0RwjIaeF40JZELUj33UvxqHW7nkDU6Y+Y7WQbuXAZmtJ2VP7T9gjI
 zKwnyXi3X2MR3m4LhAlpMVw87zpEY6eZT/O4b4wM/DbsHbxxtInixuRS4sZb21lf4/cNSe1CqD0
 mfjlFUUxXMgMITW5UbSKh2AvyTYffg==
X-Authority-Analysis: v=2.4 cv=QYNrf8bv c=1 sm=1 tr=0 ts=68fa2206 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=BAz0yG0TH0QP3-mkIuYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
 a=HhbK4dLum7pmb74im6QT:22 a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
X-Proofpoint-ORIG-GUID: WeLjqZzViYgfKw1VB0ES-yIzBLHsKPkO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180031

Hi,

On 10/22/2025 4:12 PM, Mark Brown wrote:
> On Wed, Oct 22, 2025 at 12:29:01PM +0530, Md Sadre Alam wrote:
>> On 10/22/2025 12:39 AM, Mark Brown wrote:
>>> On Tue, Oct 14, 2025 at 04:35:26PM +0530, Md Sadre Alam wrote:
>>>> IPQ5424 contains the QPIC-SPI-NAND flash controller which is the same as
>>>> the one found in IPQ9574. So let's document the IPQ5424 compatible and
>>>> use IPQ9574 as the fallback.
> 
>>> This doesn't apply against current code, please check and resend.
> 
>> Thank you for the feedback. I’d appreciate a bit more clarity on what
>> “doesn't apply against current code” refers to in this context. I’ve
>> manually applied the patch against the latest mainline (torvalds/linux) and
>> it applied cleanly without any conflicts. Please let me know if there’s a
>> specific tree or integration point I should be checking against.
> 
> I tried to apply it to the spi tree
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-6.19
I had sent v3 on the 14th, but since v2 was already applied on the 15th 
and v3 was just a resend, the error on reapplying makes sense. 
Everything looks in order now, and no further action is needed.

Thanks,
Alam.

