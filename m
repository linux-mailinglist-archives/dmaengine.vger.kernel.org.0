Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E030C1BBE5A
	for <lists+dmaengine@lfdr.de>; Tue, 28 Apr 2020 14:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgD1M4u (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Apr 2020 08:56:50 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42084 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbgD1M4t (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 28 Apr 2020 08:56:49 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03SCqkWU167004;
        Tue, 28 Apr 2020 12:56:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=4qhmUDa7F437ChnjAQ6A8+Tyq1qMBj5fTsTxjwYc8pU=;
 b=riB2txC4dB+WfIbJ8jO8RYQ9znXob3bZ56ZmZBxW7KqkDOga1rfUGMb7qU14dvAOda9d
 m8WWAxv2bH+Q9HvM9XarrdD6ldFP55+oXWVcDUH72Lr2fuPobjhKN3IJyRM40T2j0Krv
 Pj6mYhKXRaJIzWc5zofqPhD9/joQefp/VZwpPCiem7UYmOLD32RqQTKchLfYU0c7wE+X
 LEl0rSBjykJEE1MKJbMCPvL+PTRJieB9jMROEQ4MsjTxHDVdD5nlWnDb2u4LKnLDIU5h
 KkOFaJl1CbWRnGZycfbvKxi1dAjbIv1t4KvOun/B8zjeKQfx/N1E7YYO5Zbd9w4dWyZ8 0A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 30nucfyqw8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Apr 2020 12:56:38 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03SCpt9L182449;
        Tue, 28 Apr 2020 12:54:37 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 30mxwypfte-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Apr 2020 12:54:37 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03SCsYHe008311;
        Tue, 28 Apr 2020 12:54:35 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 Apr 2020 05:54:34 -0700
Date:   Tue, 28 Apr 2020 15:54:26 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     okaya@kernel.org, agross@kernel.org, bjorn.andersson@linaro.org,
        vkoul@kernel.org, dan.j.williams@intel.com,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] dmaengine: qcom_hidma: Simplify error handling path in
 hidma_probe
Message-ID: <20200428125426.GE2014@kadam>
References: <20200427111043.70218-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427111043.70218-1-christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9604 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=2 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004280100
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9604 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 priorityscore=1501
 mlxlogscore=999 impostorscore=0 suspectscore=2 malwarescore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004280100
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Apr 27, 2020 at 01:10:43PM +0200, Christophe JAILLET wrote:
> There is no need to call 'hidma_debug_uninit()' in the error handling
> path. 'hidma_debug_init()' has not been called yet.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/dma/qcom/hidma.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/dma/qcom/hidma.c b/drivers/dma/qcom/hidma.c
> index 411f91fde734..87490e125bc3 100644
> --- a/drivers/dma/qcom/hidma.c
> +++ b/drivers/dma/qcom/hidma.c
> @@ -897,7 +897,6 @@ static int hidma_probe(struct platform_device *pdev)
>  	if (msi)
            ^^^
This test doesn't work.  It will call free hidma_free_msis() if the
hidma_request_msi() call fails.  We should do:

	if (msi) {
		rc = hidma_request_msi(dmadev, pdev);
		msi = false;
	}

	if (!msi) {
		hidma_ll_setup_irq(dmadev->lldev, false);
		rc = devm_request_irq(&pdev->dev, chirq, hidma_chirq_handler,
				      0, "qcom-hidma", dmadev->lldev);
		if (rc)
			goto uninit;
	}


>  		hidma_free_msis(dmadev);
>  
> -	hidma_debug_uninit(dmadev);
>  	hidma_ll_uninit(dmadev->lldev);
>  dmafree:
>  	if (dmadev)
            ^^^^^^
This test isn't necessary and should be deleted.

regards,
dan carpenter
