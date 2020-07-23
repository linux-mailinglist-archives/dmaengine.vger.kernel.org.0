Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7AC922AB48
	for <lists+dmaengine@lfdr.de>; Thu, 23 Jul 2020 11:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbgGWJDr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 23 Jul 2020 05:03:47 -0400
Received: from mail-eopbgr70130.outbound.protection.outlook.com ([40.107.7.130]:35075
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725858AbgGWJDq (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 23 Jul 2020 05:03:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SENppMspTmggkDT+oVHJPfBjEciuX3yF3owXQN8efnqoPPb9t36MrEwA6d/NoRqhNbvC+MUmwBZfzYYz9csFkGT/zhgjGktR9l8STkp1bLUTIeSemoV8RSmYUMPRq6avzxBV2Hxpo0uCyYXFMgxS5XRHVpksFDZnqPW/aPldcxRqyXzsCmFVQMLZcj1L8tTm/1AI7dxsndct6RhAMiuChwhNBDUHMAWU8hA+DvslWqXExMIBjPR5JPV5A1qg5M+4/pYI1tL5HPEQu6QM2nUBQ8kKxV6ARJUZK8auLEijxTm+AlxNtjxzLQEKSUfvxif+s++5u0piHbljsIeqYhFAWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vgk+EWyIPtcnQ+v93CVSKIRET4N3hDoxOt5hu2VtOac=;
 b=iAUebBP5hDOGm3GdZWahmmMsLOF1KN0SMf2csiBS+ssk69HcnPyrkUBVJ10xx/el/oC6F1Q3jN0Oc+3cCPX/cokVs1ABf8YXpgJ/JwokTcr1VNCOwLxv7qvcvhnpcCDBYxjcLgwVBY4uj2AtL3Kff/uqWUaF2ZJhChAhqjYiscbp3ucueDM9axb16JaQCbao/0UbqsvrzwTT8eezHZoIocrIw4lQHQcCqZhQk30mklFyIYL2dMgGTxFVjYqkoWwcqxvrHaq0uwkOnp5QS/WRC++XkHni8BFyUy4ReONmTce7nSGtMvlpbOeJ8DnnOOoNgcKKAyVoGI9Z9ip7V6VsOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vgk+EWyIPtcnQ+v93CVSKIRET4N3hDoxOt5hu2VtOac=;
 b=Y7XIrHL05cnpj6ukoRrnismMnVt/6VXBPbzSn0uLppSb0kb+3GCVHo+RPgQtfLZnGEZKIRd2kunN2wTsCAcLalsb+hc+37LU9K4betsHwprFuRTB7b49gVyg9jFW/PihvLhdvcEXeKXe0UNZeRjMMRmqKjCMcK0oDpoGilPhdNM=
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=kontron.de;
Received: from DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:50::12)
 by DB8PR10MB3545.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:13e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Thu, 23 Jul
 2020 09:03:41 +0000
Received: from DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ac04:ef33:baf3:36f3]) by DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ac04:ef33:baf3:36f3%4]) with mapi id 15.20.3195.025; Thu, 23 Jul 2020
 09:03:41 +0000
Subject: Re: [PATCH v10 05/12] dmaengine: dma: imx-sdma: add fw_loaded and
 is_ram_script
To:     Robin Gong <yibin.gong@nxp.com>, mark.rutland@arm.com,
        broonie@kernel.org, robh+dt@kernel.org, catalin.marinas@arm.com,
        vkoul@kernel.org, will.deacon@arm.com, shawnguo@kernel.org,
        festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, dmaengine@vger.kernel.org, linux-imx@nxp.com
References: <1593523876-22387-1-git-send-email-yibin.gong@nxp.com>
 <1593523876-22387-6-git-send-email-yibin.gong@nxp.com>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
Message-ID: <1b04e4e6-ca26-3f45-e353-af81e03f85a7@kontron.de>
Date:   Thu, 23 Jul 2020 11:03:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <1593523876-22387-6-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BEXP281CA0006.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10::16)
 To DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:50::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.17] (46.142.152.98) by BEXP281CA0006.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.9 via Frontend Transport; Thu, 23 Jul 2020 09:03:39 +0000
X-Originating-IP: [46.142.152.98]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 768f9745-1108-4af4-3258-08d82ee74b29
X-MS-TrafficTypeDiagnostic: DB8PR10MB3545:
X-Microsoft-Antispam-PRVS: <DB8PR10MB3545CA34F50744B5ECAC02A2E9760@DB8PR10MB3545.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qut9XP9mKMpxtP52W3MbhjHliU5tOnuyAJnG2zQe9ee6KtDezxhOq+OqGedm2FF1zgKZ0LvQ54fz996QP+cr7luRLQD2ASFGkgCR7/7ipxFS3PntVPMGJEYp5syENMTNl5oVoUD0inYRkYUjKGoOWzUUzoRLJA821rkH6AgmHVwKo53C6qvBgVKQwAKQ/C3kUmlnYyfMBcmVr2G2L3AfgpeJvsnG6lpHquCjBvGISu+6txEZA2ImXgy3Rhv4RSwbFdJLMY4i8P9VKhQO+QXjCK16wYf1WVxxY0kNDlDH1tLJqvs2oNUHNCD6zMOK5FrH00ZLlG7qV1bQKKmEbUCtLV1FC3AVVARDB7ELfbXIvmhmn7MXfayb12YEDG+Cg+9zDwH77VjvRMk3wMzSB/+ILg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(39860400002)(136003)(396003)(366004)(36756003)(478600001)(8676002)(86362001)(16526019)(44832011)(4326008)(8936002)(2616005)(186003)(31696002)(956004)(83380400001)(52116002)(53546011)(66556008)(66476007)(6486002)(66946007)(316002)(16576012)(7416002)(26005)(31686004)(2906002)(5660300002)(921003)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: rtBA24GdlaVwIig9ckX6zTZ2SYDTx8AqxWMnczVOEx/teXprWkUp7DmHjOctZc3f5/MF5GgWPeTEryTEPHDyVj/h+PFnVRJPQo99+q6Yqi8K/nJDZn3erp9trmMoUU5rVf0cYKu/A61+w8r4f/sYEw4h/TRnYbpS42+bhwCMNZYxoFU9FNbcMA5ScqxIAELUuEbb1MybUccoiFnGOy3EiwN7cxbn5xZbW38L2k9DvT5upi6AGEt7YOOHVHS991UsF3AqL4nAPHiv/0smD+t05AeCtwOOpwh6CC0Jn5tfOU/NDAbKeTnz6QP7taWBIYtLv1yZKZtZAUHup5L+H6N9pFCEihhAAO7Bh49w6MBGClLgUiV7ufKURp/xUKyorV3jPlNfGyLCSSvO2NtbuNLyPM9pwpfeVztafutlnWgc9lQ8kieME8T9JKvhm+P4PSF26VDSHSiHNQHODyxnBimJ5E8ZmHZCAF2PEGZu244kiFU=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 768f9745-1108-4af4-3258-08d82ee74b29
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2020 09:03:40.8667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WA6SqgI3AA5j2mL46BygATSQzxLFRmBV2AlsUKiKpUqpCxDcevOZvMVI158LBvnqrt44NT4fjf1kGg0qecjzGtQI8tGONadjmkPKM6jIy7Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3545
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Robin,

On 30.06.20 15:31, Robin Gong wrote:
> Add 'fw_loaded' and 'is_ram_script' to check if the script used by channel
> is ram script and it's loaded or not, so that could prevent meaningless
> following malloc dma descriptor and bd allocate in sdma_transfer_init(),
> otherwise memory may be consumed out potentially without free in case
> that spi fallback into pio while dma transfer failed by sdma firmware not
> ready(next ERR009165 patch depends on sdma RAM scripts/firmware).
> 
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> Acked-By: Vinod Koul <vkoul@kernel.org>
> ---
>   drivers/dma/imx-sdma.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index 5411e01e..ce1c83e 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -379,6 +379,7 @@ struct sdma_channel {
>   	enum dma_status			status;
>   	struct imx_dma_data		data;
>   	struct work_struct		terminate_worker;
> +	bool				is_ram_script;
>   };
>   
>   #define IMX_DMA_SG_LOOP		BIT(0)
> @@ -443,6 +444,7 @@ struct sdma_engine {
>   	struct sdma_buffer_descriptor	*bd0;
>   	/* clock ratio for AHB:SDMA core. 1:1 is 1, 2:1 is 0*/
>   	bool				clk_ratio;
> +	bool                            fw_loaded;
>   };
>   
>   static int sdma_config_write(struct dma_chan *chan,
> @@ -929,6 +931,7 @@ static void sdma_get_pc(struct sdma_channel *sdmac,
>   	case IMX_DMATYPE_SSI_DUAL:
>   		per_2_emi = sdma->script_addrs->ssish_2_mcu_addr;
>   		emi_2_per = sdma->script_addrs->mcu_2_ssish_addr;
> +		sdmac->is_ram_script = true;
>   		break;
>   	case IMX_DMATYPE_SSI_SP:
>   	case IMX_DMATYPE_MMC:
> @@ -943,6 +946,7 @@ static void sdma_get_pc(struct sdma_channel *sdmac,
>   		per_2_emi = sdma->script_addrs->asrc_2_mcu_addr;
>   		emi_2_per = sdma->script_addrs->asrc_2_mcu_addr;
>   		per_2_per = sdma->script_addrs->per_2_per_addr;
> +		sdmac->is_ram_script = true;
>   		break;
>   	case IMX_DMATYPE_ASRC_SP:
>   		per_2_emi = sdma->script_addrs->shp_2_mcu_addr;
> @@ -1339,6 +1343,11 @@ static struct sdma_desc *sdma_transfer_init(struct sdma_channel *sdmac,
>   {
>   	struct sdma_desc *desc;
>   
> +	if (!sdmac->sdma->fw_loaded && sdmac->is_ram_script) {
> +		dev_err(sdmac->sdma->dev, "sdma firmware not ready!\n");
> +		goto err_out;
> +	}

I tried your v10 patches on next-20200722 with i.MX8MM and it mostly 
seems to work fine.

When I tried first, I had the imx-sdma driver compiled into the kernel, 
so it didn't load the firmware and fell back to the ROM scripts.
With this, SPI transactions work just fine, but I got the above error 
message printed continuously when sending data in SPI3 via spidev.

When I build imx-sdma as a module, the firmware is loaded correctly and 
everything works as expected.

Can you have a look at this and provide a fix?

Thanks,
Frieder

> +
>   	desc = kzalloc((sizeof(*desc)), GFP_NOWAIT);
>   	if (!desc)
>   		goto err_out;
> @@ -1589,6 +1598,8 @@ static int sdma_config_write(struct dma_chan *chan,
>   {
>   	struct sdma_channel *sdmac = to_sdma_chan(chan);
>   
> +	sdmac->is_ram_script = false;
> +
>   	if (direction == DMA_DEV_TO_MEM) {
>   		sdmac->per_address = dmaengine_cfg->src_addr;
>   		sdmac->watermark_level = dmaengine_cfg->src_maxburst *
> @@ -1768,6 +1779,8 @@ static void sdma_load_firmware(const struct firmware *fw, void *context)
>   
>   	sdma_add_scripts(sdma, addr);
>   
> +	sdma->fw_loaded = true;
> +
>   	dev_info(sdma->dev, "loaded firmware %d.%d\n",
>   			header->version_major,
>   			header->version_minor);
> 
