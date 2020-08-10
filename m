Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFEBE24029D
	for <lists+dmaengine@lfdr.de>; Mon, 10 Aug 2020 09:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgHJHcx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 10 Aug 2020 03:32:53 -0400
Received: from mail-eopbgr40127.outbound.protection.outlook.com ([40.107.4.127]:25251
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726569AbgHJHcv (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 10 Aug 2020 03:32:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kqAY2JlfC5JMQiXQy72prOfoc7OWoJBLeZsiPUXW7DLTmqd5M5+98bFpVtANC5450BKw6UxQcSqSsMaCt177xv8hZRzRjlgOdRAl1J4IShodub9XMdrvIMom7KZdQTDVy0uldM3OvA/rbUVVQojMqbmYeRW93QPHApPMtF3ZIqf192Pxn8E8Gc0cD1sR6wkJDMYgVbb49VNzDKQ1GsvhzR4Fx56R3HuLrK7TuDZff23R5gBFkoFUz145oS1rMmodHv09b0ws/umJjvU7UzS1ZREy3UjZVRkdYEu9ubhYt1X2WY77RQz4wt98S9UYkNruBFTesGkhci/mSHZEF7ZR4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tc9IW4hoT1tZkhIMEzBBVRF1zUZ/g9YJQLse3mLtcdw=;
 b=CtynKHPbyYjsGhPrZALL8UX24MHRvDJXb4dwPefbstAGiLnEiX4SI8ULnwHFfeQ0GGKtwWX3+TwZRtmVaXuYwneRAvVB5Kw8U7F2jDXrEv3FcKT7es2Ee9MgNiCdVkC+8YxruuTEV6NYaG7ea1vRg2Kpr7PPHF3wqCeBfEFKhCt7Owp+HEpJBeLyxCPgJ4tNGKfANQ8FWjC9rv3xu4Z82ofr/8iU6qllN4qbUuzJFgSzhghag1XsrIGq5gIL/zPm6cWuXuyi4uEqjQeE7sjnqin9Q38Sibhf8rQW5i7LiSRlJ8mD4PAhCMz3AFRMKz/zYULONUQAIy3epyQjuAG4AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tc9IW4hoT1tZkhIMEzBBVRF1zUZ/g9YJQLse3mLtcdw=;
 b=MWIH91XeuqHc4pa2tNQAwlWxvaV6BHlLz0WmpxzWpWEUc9j0y1TD0KN0XpAC1hFA/+pKdmqSmWvuBPk269MNvGo/p25/XEG9J1zhqgnSO+uW5Q4bkYN+3+sh37iz2vXZj+p0lFIbEVHPvvPqdjgS2CBd1zZ6Sr7ZJuA4YjRd7MY=
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=kontron.de;
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:157::14)
 by AM0PR10MB3617.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:15f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Mon, 10 Aug
 2020 07:32:46 +0000
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::51f5:dfc0:24bb:309c]) by AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::51f5:dfc0:24bb:309c%7]) with mapi id 15.20.3261.024; Mon, 10 Aug 2020
 07:32:46 +0000
Subject: Re: [PATCH v11 12/12] dmaengine: imx-sdma: add uart rom script
To:     Robin Gong <yibin.gong@nxp.com>, mark.rutland@arm.com,
        broonie@kernel.org, robh+dt@kernel.org, catalin.marinas@arm.com,
        vkoul@kernel.org, will.deacon@arm.com, shawnguo@kernel.org,
        festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, dmaengine@vger.kernel.org, linux-imx@nxp.com
References: <1595616685-9987-1-git-send-email-yibin.gong@nxp.com>
 <1595616685-9987-13-git-send-email-yibin.gong@nxp.com>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
Message-ID: <89946dc6-6c0f-b3d5-9c9a-517f1ed7b5e1@kontron.de>
Date:   Mon, 10 Aug 2020 09:32:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <1595616685-9987-13-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0107.eurprd02.prod.outlook.com
 (2603:10a6:208:154::48) To AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:157::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.99.60] (80.147.118.32) by AM0PR02CA0107.eurprd02.prod.outlook.com (2603:10a6:208:154::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.20 via Frontend Transport; Mon, 10 Aug 2020 07:32:45 +0000
X-Originating-IP: [80.147.118.32]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f572f286-5146-40aa-ac3d-08d83cff938a
X-MS-TrafficTypeDiagnostic: AM0PR10MB3617:
X-Microsoft-Antispam-PRVS: <AM0PR10MB36173BDE7887CDE9797D8B92E9440@AM0PR10MB3617.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wEAWs8wDhczFWLmu7VdEtJ/7MA+VhMJ9oFWoyN9A2yxZr2lt4BGaRe6Bn6PFCLrgNtizyiKVweulvbynMH0/7iHrnPEa3C/YqWwEXdthErSwF41Xqd7zu8nnWfRNSGbj2Ers5GGtt7yRHnJqomOPAPCLGZwGpfb2bPldSVgS29cZekeT3re+cdokJKLwyQWGDlhssfUSFJAioB8E0oQv9nuJkhc25z+Inw60Spfbq5LpI1ffW1ge8H8x9mQ11Ux2h7WHeSd2rKFAFpMh1H2FZxjLa4U4dj7DhzLYDdfJmo1bAwnesbbSp3viTN3D1T4XRv88dAJFK/eukTEob5qkIs45C2kfjeqBgEv0qn2YE3BMNcOXHx6U1+iMPiU6Dy2FzMMIyXspMeMM4PFxtVOAKHk8epTtvVUS0vf/54ipaAVu99QWGgMvr/LlxpB9jEBhbqY1Su161NBh+0IiZNjnYbBD2EvEhUu6Eb5L2IrVWZE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(136003)(396003)(366004)(376002)(39850400004)(36756003)(53546011)(2906002)(44832011)(8936002)(8676002)(66556008)(66476007)(45080400002)(26005)(31696002)(86362001)(16576012)(316002)(66946007)(7416002)(4326008)(186003)(16526019)(5660300002)(52116002)(31686004)(6486002)(956004)(2616005)(966005)(478600001)(83380400001)(921003)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: CWnfoRRrz/r7n29kvET7xMZW6VdI50yOMevZMWDc2RDu6lZdIkWE/KMQi91rj+8KHaADqltL9phu01wFY2BxsOJaIpXXqoI2Wm3KZ9+a6K14eJz2NU+0CFJslWJ0UkEyZyUoemkosIkTzOgloiFsIXv9wWb73FyybsAfYUqdEGE3iDJyz3B2lVzY6xkr9RDza/04+PCGtcIvz9bX3J2hXNnClw156GHRMxWVh8vz53IByQWlfqZ0qGRj0NYnD0dEdJwVpo2MWtGHQ4ntYByIBVr9KkrVqiZHctoQ7pYbkrfJNXq8sJYtWb3ajIvKgq1p3R0w39BUoYMmxdVpKDlN4tt7kpCi29r6ITVrKIXRkz6LXAevRA33Q5d9uaMBEsi9bVZj/1Em0Lat1MqvGBIDKO9TP+9RtnGT+fDe3r5Aj0gP4Egadaw6cswlet7sfS7ds+YI+UQvDWhQFNzLyj68KNrbbb0zqL2gRpq5cBKT9JU4rKfwRrx/UNyVQyLEFxTeikdYLZwPRkunnEJWryGpvepK3C1bh+bkFq06VY89Uub+R1FjChDnjL6qoV2hOQv8CgSKU2T1ca0tLwy7nWUaZhCnKC8FygU/CPlN9gMpKH43DkkwWkzT5nwM8x+bexLlJyqb4J5Oy4QIkZ2TpIYffQ==
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f572f286-5146-40aa-ac3d-08d83cff938a
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2020 07:32:46.5639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kpo2hEXZdm4VIj5PxBTSRhyO+LvCXwtG6Z5l2VQFtz7UphUI++Boi8Z4GyTdTdFybELyMoKlWgJEuOx/DpOlPUrOOXiC/GpIfIyv4iYvOXg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3617
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Robin,

On 24.07.20 20:51, Robin Gong wrote:
> For the compatibility of NXP internal legacy kernel before 4.19 which
> is based on uart ram script and upstreaming kernel based on uart rom
> script, add both uart ram/rom script in latest sdma firmware. By default
> uart rom script used.
> Besides, add two multi-fifo scripts for SAI/PDM on i.mx8m/8mm and add
> back qspi script miss for v4(i.mx7d/8m/8mm family, but v3 is for i.mx6).
> 
> rom script:
>          uart_2_mcu_addr
> 	uartsh_2_mcu_addr /* through spba bus */
> am script:
> 	uart_2_mcu_ram_addr
> 	uartsh_2_mcu_ram_addr /* through spba bus */
> 
> Please get latest sdma firmware from the below and put them into the path
> (/lib/firmware/imx/sdma/):
> https://eur04.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ffirmware%2Flinux-firmware.git&amp;data=02%7C01%7Cfrieder.schrempf%40kontron.de%7Caa98331fadca476ca15c08d82fbdaf32%7C8c9d3c973fd941c8a2b1646f3942daf1%7C0%7C0%7C637311839017457806&amp;sdata=cbM33k4fdr0IAni1njQWgIrzxbEJ%2BQBkxN10fnagO6k%3D&amp;reserved=0
> /tree/imx/sdma
> 
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> Acked-by: Vinod Koul <vkoul@kernel.org>

This patch seems to break UART DMA in case the ROM firmware is used. In 
that case sdma->script_number is set to SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V1, 
so the ROM scripts at uart_2_mcu_addr and uartsh_2_mcu_addr will never 
be added in sdma_add_scripts() as they are now moved beyond the V1 max 
index.

Reverting this patch fixes UART DMA with ROM firmware.
Can you please find a way to fix this or just drop this change?

Thanks,
Frieder

> ---
>   drivers/dma/imx-sdma.c                     | 4 ++--
>   include/linux/platform_data/dma-imx-sdma.h | 8 ++++++--
>   2 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index 8735606..5900e32 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -1729,8 +1729,8 @@ static void sdma_issue_pending(struct dma_chan *chan)
>   
>   #define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V1	34
>   #define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V2	38
> -#define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V3	41
> -#define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V4	42
> +#define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V3	45
> +#define SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V4	46
>   
>   static void sdma_add_scripts(struct sdma_engine *sdma,
>   		const struct sdma_script_start_addrs *addr)
> diff --git a/include/linux/platform_data/dma-imx-sdma.h b/include/linux/platform_data/dma-imx-sdma.h
> index 30e676b..e12d2e8 100644
> --- a/include/linux/platform_data/dma-imx-sdma.h
> +++ b/include/linux/platform_data/dma-imx-sdma.h
> @@ -20,12 +20,12 @@ struct sdma_script_start_addrs {
>   	s32 per_2_firi_addr;
>   	s32 mcu_2_firi_addr;
>   	s32 uart_2_per_addr;
> -	s32 uart_2_mcu_addr;
> +	s32 uart_2_mcu_ram_addr;
>   	s32 per_2_app_addr;
>   	s32 mcu_2_app_addr;
>   	s32 per_2_per_addr;
>   	s32 uartsh_2_per_addr;
> -	s32 uartsh_2_mcu_addr;
> +	s32 uartsh_2_mcu_ram_addr;
>   	s32 per_2_shp_addr;
>   	s32 mcu_2_shp_addr;
>   	s32 ata_2_mcu_addr;
> @@ -52,6 +52,10 @@ struct sdma_script_start_addrs {
>   	s32 zcanfd_2_mcu_addr;
>   	s32 zqspi_2_mcu_addr;
>   	s32 mcu_2_ecspi_addr;
> +	s32 mcu_2_sai_addr;
> +	s32 sai_2_mcu_addr;
> +	s32 uart_2_mcu_addr;
> +	s32 uartsh_2_mcu_addr;
>   	/* End of v3 array */
>   	s32 mcu_2_zqspi_addr;
>   	/* End of v4 array */
> 
