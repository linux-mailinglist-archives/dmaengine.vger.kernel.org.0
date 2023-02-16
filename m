Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3CA698F53
	for <lists+dmaengine@lfdr.de>; Thu, 16 Feb 2023 10:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjBPJGr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Feb 2023 04:06:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjBPJGq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 16 Feb 2023 04:06:46 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A30B41097;
        Thu, 16 Feb 2023 01:06:41 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31G7kTpT012454;
        Thu, 16 Feb 2023 09:06:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=oDZWguDzkkgUlhjTXniQgW8NbcX0l1LLI9MK2woh0/c=;
 b=OfTlQqnfR1j1VbZx81MZOPaYaTTHadETCEakTHA9nTCaDpB3fjAkVgY5bC0izpVGq0BB
 0TFwNP2unVsoIGUz4yZe8QWF9pkodruFYaTVgr4kBvY0AEcVsknXsJ/bm/ZTUzuCTl9r
 vMvoYZOyF2kgHhF3g3FEsd6GKFvoKeyOVSFFdtFGJY0bP5b2QYCbrFQ0AVsjE0mkZLa8
 R5HvpbZQuAqDIKJkzCZkcaz8unYHeenJLpu9iNzwtKLCQl7q5ffbSY5dj/VwEvXRqYcK
 ABhEyMgdz1BsSKZnUnw/USRcSAei9yCoAfnoKnfnt4MLWL9sJeVd2fw6Ezxvg5gU6/pL 8Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nsf973h6c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Feb 2023 09:06:34 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31G8pZN6002683;
        Thu, 16 Feb 2023 09:06:33 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nsf973h5f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Feb 2023 09:06:33 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31G4JYkl010684;
        Thu, 16 Feb 2023 09:06:32 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3np2n6xe4t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Feb 2023 09:06:31 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31G96THf48300430
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Feb 2023 09:06:29 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 62F4F20049;
        Thu, 16 Feb 2023 09:06:29 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B58E820043;
        Thu, 16 Feb 2023 09:06:28 +0000 (GMT)
Received: from [9.179.9.244] (unknown [9.179.9.244])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 16 Feb 2023 09:06:28 +0000 (GMT)
Message-ID: <f479ae76754c5e3b1a9d435e6d1435ea9d293e54.camel@linux.ibm.com>
Subject: Re: [PATCH 2/2] dmaengine: make QCOM_HIDMA depend on HAS_IOMEM
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-s390@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org
Date:   Thu, 16 Feb 2023 10:06:28 +0100
In-Reply-To: <20230216073403.451455-2-bhe@redhat.com>
References: <20230216073403.451455-1-bhe@redhat.com>
         <20230216073403.451455-2-bhe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jft_d8iaQoMDqmwl8QUaAms192uLi51l
X-Proofpoint-GUID: ufE62dfTdphCQlr0y9mr8FaQKnSSoo71
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-16_06,2023-02-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 impostorscore=0 clxscore=1011 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302160075
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, 2023-02-16 at 15:34 +0800, Baoquan He wrote:
> On s390 systems (aka mainframes), it has classic channel devices for
> networking and permanent storage that are currently even more common
> than PCI devices. Hence it could have a fully functional s390 kernel
> with CONFIG_PCI=3Dn, then the relevant iomem mapping functions
> [including ioremap(), devm_ioremap(), etc.] are not available.
>=20
> Here let QCOM_HIDMA depend on HAS_IOMEM so that it won't be built to
> cause below compiling error if PCI is unset.
>=20
> --------------------------------------------------------
> ld: drivers/dma/qcom/hidma.o: in function `hidma_probe':
> hidma.c:(.text+0x4b46): undefined reference to `devm_ioremap_resource'
> ld: hidma.c:(.text+0x4b9e): undefined reference to `devm_ioremap_resource'
> make[1]: *** [scripts/Makefile.vmlinux:35: vmlinux] Error 1
> make: *** [Makefile:1264: vmlinux] Error 2
>=20
> Link: https://lore.kernel.org/all/Y0TcaZD4nB1w+mAQ@MiWiFi-R3L-srv/T/#u
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Cc: Andy Gross <agross@kernel.org>
> Cc: Bjorn Andersson <andersson@kernel.org>
> Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: dmaengine@vger.kernel.org
> ---
>  drivers/dma/qcom/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/dma/qcom/Kconfig b/drivers/dma/qcom/Kconfig
> index 3f926a653bd8..ace75d7b835a 100644
> --- a/drivers/dma/qcom/Kconfig
> +++ b/drivers/dma/qcom/Kconfig
> @@ -45,6 +45,7 @@ config QCOM_HIDMA_MGMT
>=20=20
>  config QCOM_HIDMA
>  	tristate "Qualcomm Technologies HIDMA Channel support"
> +	depends on HAS_IOMEM
>  	select DMA_ENGINE
>  	help
>  	  Enable support for the Qualcomm Technologies HIDMA controller.

Thanks for the patch!

Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com?

