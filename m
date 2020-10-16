Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4700F2902CD
	for <lists+dmaengine@lfdr.de>; Fri, 16 Oct 2020 12:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395316AbgJPKcM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 16 Oct 2020 06:32:12 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:51607 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395317AbgJPKcK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 16 Oct 2020 06:32:10 -0400
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20201016103207epoutp02581c7129bac48a0406cfdeaea5cf1314~_cmxpmTCC1758017580epoutp02v
        for <dmaengine@vger.kernel.org>; Fri, 16 Oct 2020 10:32:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20201016103207epoutp02581c7129bac48a0406cfdeaea5cf1314~_cmxpmTCC1758017580epoutp02v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1602844327;
        bh=CoMBFzjjQTDKAU3AQQ0ee2Ct+wTe7TkGcgrKQcC1XCU=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=MxkWOPsGIA2N2kdSVsn2MlkaAQDKyK4F1WqhRZBG+Z1G3zUVnhLuefVRECzBtYBPq
         fKwkycwo51NRZAO9FdXIefDiYSv1DbqxuqXHJnK5zXJAVfajrUlbLlv8+36d0ARnfh
         coFEOrIvuEt61wpahRxooHZ/7e/Ic8bjU7WttMIk=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20201016103206epcas5p39b95136b060a5d93cc04b2f12af0d567~_cmxHhcMx1427314273epcas5p3S;
        Fri, 16 Oct 2020 10:32:06 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1D.F2.09573.6A6798F5; Fri, 16 Oct 2020 19:32:06 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20201016103055epcas5p468331470587e3640d9596ae92211f42e~_cluX8U3_0775007750epcas5p4g;
        Fri, 16 Oct 2020 10:30:55 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201016103055epsmtrp1fac513e911d78dd9a9b8955900bd4022~_cluXScnM1161511615epsmtrp1O;
        Fri, 16 Oct 2020 10:30:55 +0000 (GMT)
X-AuditID: b6c32a49-a7dff70000002565-33-5f8976a6f28d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        CA.D2.08745.E56798F5; Fri, 16 Oct 2020 19:30:54 +0900 (KST)
Received: from RWINDS2E175 (unknown [10.218.224.178]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20201016103054epsmtip1ee105f750d6ca33d322e0115b94af5c1~_cltmCHd42862028620epsmtip1y;
        Fri, 16 Oct 2020 10:30:54 +0000 (GMT)
From:   "Surendran K" <surendran.k@samsung.com>
To:     "'Vinod Koul'" <vkoul@kernel.org>
Cc:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <shaik.ameer@samsung.com>, <alim.akhtar@samsung.com>,
        <pankaj.dubey@samsung.com>
In-Reply-To: <20201014043933.GQ2968@vkoul-mobl>
Subject: RE: [PATCH] DMA: PL330: Remove unreachable code
Date:   Fri, 16 Oct 2020 03:30:53 -0700
Message-ID: <0cc501d6a3a7$6d9203c0$48b60b40$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQEWfHRKKVMIDHyIT6p/8HKRN/8LDAIA6c1hAtDW/C2q88bboA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRjG++9sZ8fh6mgD3xxlzi4o5KULLNQs64MJRhTRBWyuPF5Sp21L
        TaLMUnKmrVBrS2c30qZZram1pGxZaibdZi00maWJC9E5M8W02o6R337v9XkfeAnM/TzLk0iU
        yCmpRJwswDnM+me+vqtupueLAn+qVwgtmnpcWF0yzRK+N5Thwmt1Y2xhc+8jtvBhdyu2EY/Q
        afPxiCK9FkXYdUu2Y/s4IbFUcmI6JQ3YEMNJaP+Qx0xr4WQOmHtQNmomFMiFAHItVCprkAJx
        CHfyEYLqbBWbDkYRdD2+hNGBHUH5mU5cgQjniPLSUjpvQDCts7LowIrAPNnPcuzFyVVgUzRg
        DuaRy0HfZ8EdTRhZguBuVwtyFFzIAGhrGWM7eCEpBFVZlXOA+XfAYO1xLuKS62Hg89Qsu0Gb
        qo/pYIz0goahMow2sRQm+2+yHNfxyHD4VEfRLR4w+LzZaQfIXAImGisQ3b8Fhk53MmheCNYW
        PZtmTxg8lzfLSWAeOceiORM05h6c5jBoMpUxHVoY6Qt3DAF0ejGUvKxl0LrzoXCqb3Y9Fx5o
        /vFyaPs9MXsyH0y1T1hKJFDPcaae40w9x4L6v9oVxNSiRVSaLCWekq1LC5JQGf4ycYrsiCTe
        /2Bqig45v8Zv6wP02TLib0QMAhkREJiAx7Xy80Tu3Fjx0SxKmiqSHkmmZEbEJ5gCD65g4tV+
        dzJeLKeSKCqNkv6rMggXz2yG9ldK+ZribZHfumpd6xNfvK8tnjKyfTptka1Bla8beVHFM0WS
        Bm83N+/p6IJ9FcqI3bebReGpX0pdc+wX3uZ+Fe+F0W7jPcaKmbqPFb2xt+UrhwJKD/1O5lcF
        te1ad1emjP6xedONuOCcmo6sfOkBdcPT1dOaqzNRpsAd2320Nluhdaf9sIV3+EWHZvKE3lBU
        sN87tN3UGGyTdzy5ZUkaeha8gNPkMm6pepMbqIpzXSQqUjZVDSRYrpw8G9V9fHCe5PrqPZJl
        Bv13vSAmpHjY08S9lZ96DIYr+iubxF6hDy/fK6y2Z9yP020eFxj3vAs7pdj5doFZ3l7NvzgY
        Xhdo2ypgyhLEQX6YVCb+AxIbLGakAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrELMWRmVeSWpSXmKPExsWy7bCSnG5cWWe8wbc2S4sH87axWaye+pfV
        4vKuOWwWi7Z+Ybc48nA3u8XOOyeYHdg8Nq3qZPPo27KK0ePzJrkA5igum5TUnMyy1CJ9uwSu
        jNPX2lgKjnNVPL9xj7GB8QhHFyMHh4SAicSEGQpdjFwcQgI7GCWm75nF0sXICRSXlvh4fjcz
        hC0ssfLfc3aIoheMErM+PGUHSbAJ6Ep87NoOViQioCqx5ckDNpAiZoGZjBJX2++yQHRsZJRY
        sfg3WBWngL7EyeNfwLqFBSwkZs5ZARZnAere9eoeK4jNK2Ap8fzubyhbUOLkzCcsIKcyC+hJ
        tG1kBAkzC8hLbH87B+o6BYmfT5exgpSICDhJ3NyaClEiLvHy6BH2CYzCs5AMmoUwaBaSQbOQ
        dCxgZFnFKJlaUJybnltsWGCUl1quV5yYW1yal66XnJ+7iREcLVpaOxj3rPqgd4iRiYPxEKME
        B7OSCO8r6bZ4Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4rxfZy2MExJITyxJzU5NLUgtgskycXBK
        NTCd/r0wS5PtWJlFWq2Ds/79y05lkre2T2hkK0wsX+bw2Xjjs126n9weObecZJg952K707se
        paf7RZYWndz5pyfsVORR77dzVV4zuqrbP0jLuaMR1vX4cP+jr7EOORUBOzQ/8+td3Cr3vvSz
        55/S5/cTZwmwFG7a83tif/yU4pKIazpq3vcqn/q51yvZnZ0gnxTx8+++vDNm1X8/Vjnf3OLz
        a1apa4rMtpP5bJ2dURqKGb/mHHvPu9huQuyNaXtaluwvTeN5m27N/izBMUV3kZ28vea/9003
        SjdIGF7lF63MZNQvNIvRaN6wJTFG/IJnv+PSJpfNR2wu2k39sm9rKLve/fMnGS5lL3kXzN7n
        y6/EUpyRaKjFXFScCABFOBl5BQMAAA==
X-CMS-MailID: 20201016103055epcas5p468331470587e3640d9596ae92211f42e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20201013122030epcas5p2e576d5a2ebfaf9df8078e6ee70f3765c
References: <CGME20201013122030epcas5p2e576d5a2ebfaf9df8078e6ee70f3765c@epcas5p2.samsung.com>
        <20201013114713.28754-1-surendran.k@samsung.com>
        <20201014043933.GQ2968@vkoul-mobl>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,
Thanks for pointing it out, I missed it. Will send V2 with correction.

Regards,
Surendran.

-----Original Message-----
From: Vinod Koul [mailto:vkoul@kernel.org] 
Sent: Tuesday, October 13, 2020 9:40 PM
To: Surendran K <surendran.k@samsung.com>
Cc: dmaengine@vger.kernel.org; linux-kernel@vger.kernel.org;
shaik.ameer@samsung.com; alim.akhtar@samsung.com; pankaj.dubey@samsung.com
Subject: Re: [PATCH] DMA: PL330: Remove unreachable code

On 13-10-20, 17:17, Surendran K wrote:
> _setup_req(..) never returns negative value.
> Hence the condition ret < 0 is never met

The subsystem is "dmaengine", git log would tell you the tags to use


> 
> Signed-off-by: Surendran K <surendran.k@samsung.com>
> ---
>  drivers/dma/pl330.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c index 
> e9f0101d92fa..8355586c9788 100644
> --- a/drivers/dma/pl330.c
> +++ b/drivers/dma/pl330.c
> @@ -1527,8 +1527,6 @@ static int pl330_submit_req(struct pl330_thread 
> *thrd,
>  
>  	/* First dry run to check if req is acceptable */
>  	ret = _setup_req(pl330, 1, thrd, idx, &xs);
> -	if (ret < 0)
> -		goto xfer_exit;
>  
>  	if (ret > pl330->mcbufsz / 2) {
>  		dev_info(pl330->ddma.dev, "%s:%d Try increasing mcbufsz
(%i/%i)\n",
> --
> 2.17.1

--
~Vinod

