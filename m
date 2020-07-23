Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED1222AE69
	for <lists+dmaengine@lfdr.de>; Thu, 23 Jul 2020 13:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbgGWLvx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 23 Jul 2020 07:51:53 -0400
Received: from mail-eopbgr60108.outbound.protection.outlook.com ([40.107.6.108]:20747
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728134AbgGWLvw (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 23 Jul 2020 07:51:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SWlT8ZIWnW3heWrVOnF+cjkumPjoXJGGBXHBzf3yF3WuYjcGDrBMV3ZbwgYjWhv7nDmrqWOXbVmemtKZZPsuKojEju7ycqA9V9j7NZIUKMgquv6GibEqI9yStzqRZOQ5feFo1siq0PAkwZf5eBpmGIvXbGIP6ndiAXrYkyyNSHDJNNhNKEfREul0dIT/zhwMoa7LOIjJUT/8oVU3HgTzmHNdw4yflA/v1PW7V2nEUs3mkyQekjJW2AwOWuD/c0Z8ck2/Bc9wFFi9bMt/x9bgwyr8xm5RJElwS94LTPt5PRxxIAGp0GQVcTfygnWmEku05E8hboKZ0ETV3ntDKDTHlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7urlA14sQb3Vu+OSioXCRIRDU67/cHStLBtzvXygwT8=;
 b=md1ie3RW3gF5mnAal4+gY4mTidlZaxPz8PZfIuTY8rH31dDuGAXd/Iy3f9A5f7JrXAAS/PD1j6rxcMFcJLujdJAsr7+alk968fmc2S1TUnxvxvkIgzmy+bwS+WUbGY0PAU0//bsPFDFy/eHzeLE0JPkb6PZWlHby7MOJhf9nbD4CdUHtdcqsMFUp1Px70uHvr0REMJJk6gxw7ZCI+Qd3DJ1NHLYONW3RekD0vhHDYyRL1ciAL+xkuAxhDyFpVuonoahpQGN4/nLJENAualFT6ndXoHEdIB5cmgYRoWITCVaA261Ij9mmIsx+NUF7T7Bi79pVO51waTlYDGNxbedNJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7urlA14sQb3Vu+OSioXCRIRDU67/cHStLBtzvXygwT8=;
 b=EPW0FMSZvJTCbMD4q6pZu70NIL6I8zhOQZlvU3qOK2uKX2ow1BCZkvlUBmFU6tJAOwN5U6p0IHAhR9cAJr/pmG6pcBzeJDWI5lt5OVK5TCU6kD5vERFxk3A7t9AAr6VzAq0fbzHhDQ0aetFvH5O8hxaH4oeijWLlNCCayL9fUYs=
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=kontron.de;
Received: from DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:50::12)
 by DB8PR10MB3863.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:168::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Thu, 23 Jul
 2020 11:51:47 +0000
Received: from DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ac04:ef33:baf3:36f3]) by DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ac04:ef33:baf3:36f3%4]) with mapi id 15.20.3195.025; Thu, 23 Jul 2020
 11:51:47 +0000
Subject: Re: [PATCH v10 05/12] dmaengine: dma: imx-sdma: add fw_loaded and
 is_ram_script
To:     Robin Gong <yibin.gong@nxp.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "martin.fuzzey@flowbird.group" <martin.fuzzey@flowbird.group>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "matthias.schiffer@ew.tq-group.com" 
        <matthias.schiffer@ew.tq-group.com>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
References: <1593523876-22387-1-git-send-email-yibin.gong@nxp.com>
 <1593523876-22387-6-git-send-email-yibin.gong@nxp.com>
 <1b04e4e6-ca26-3f45-e353-af81e03f85a7@kontron.de>
 <VE1PR04MB66385FC4FE591EAFA8CB7D8289760@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <VE1PR04MB6638BEA5C2594FEBFDE9318589760@VE1PR04MB6638.eurprd04.prod.outlook.com>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
Message-ID: <22e53878-42e2-78ed-c460-3fa339c306ad@kontron.de>
Date:   Thu, 23 Jul 2020 13:51:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <VE1PR04MB6638BEA5C2594FEBFDE9318589760@VE1PR04MB6638.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM5PR0202CA0008.eurprd02.prod.outlook.com
 (2603:10a6:203:69::18) To DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:50::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.17] (46.142.152.98) by AM5PR0202CA0008.eurprd02.prod.outlook.com (2603:10a6:203:69::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.22 via Frontend Transport; Thu, 23 Jul 2020 11:51:45 +0000
X-Originating-IP: [46.142.152.98]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9e0efc1-ee5a-4f9e-69cf-08d82efec6ec
X-MS-TrafficTypeDiagnostic: DB8PR10MB3863:
X-Microsoft-Antispam-PRVS: <DB8PR10MB3863004B58D49300C2B65452E9760@DB8PR10MB3863.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BTpve2sTLNx7sdvyDJ/IegZlcuXtXrH8sDONPYcZPi1DzjKN5HW9GidfGiMWnU9tYAucteBVW4X9O6/KjeWKXvUyiCTex6Q2OyopKRvhVpAaMeWO7Yg0YEJgghPQxgI3U6P+CHz1Hdyrb+DygL6VHcfIW49kxqgIfi8w+9TeH6s8pLf3TDfDQ/qbAQB/m8acFMcre1liVlCd4UiEr9lcD/JBDNTKiKREvD7jrQY/e9h+BLfBd4aMu0sgjAWsw8ZDk8ouTT6jQFWwPPadMcMHV5yucwFSSeDL6Mii4YU6QX5YEbJAdlnyj3aINksdJCSwN+S8Bf1ETk4uxurT6cbXnLvW9fQ5zPNX1gemAxEZA88Tj92Yz7vPM+IGn6VSHbjOqWwMUpDajuA1YXH41wZuD9UdWlJTeKQrk2bixBVvgzYMe5Wge398Vg5DwIvhUvq0kavd5vXEf37jQ91vTWarTOA8j77tGU/QMBI7wY5ue1I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(7416002)(2906002)(5660300002)(110136005)(4326008)(8676002)(54906003)(186003)(316002)(478600001)(45080400002)(16576012)(36756003)(8936002)(53546011)(52116002)(16526019)(6486002)(44832011)(86362001)(26005)(966005)(31696002)(83380400001)(31686004)(66946007)(2616005)(66556008)(66476007)(956004)(921003)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: kJTFheUPCkAiaiELRUjs+YPYC4HcUcnKCnAVyeJVvu2j/2qmBMWQcilYw1kjenQQa5Upuugs9/BXJdX5wOdyOtR0pglYJkC7BwVo9AF2hUTcNUvkSKNLKjnIiI+xvFozGAg762L678gs/1FBHoJTt23QBvYw5PKrp1eMzxoeHFoZvtqHqfaqJMUWJPJILhC8XlAub27kZX5zMWKoVExKWDx1ksRYoLWKioCxzBitHzLXo5VhCWrHeF1AS4QMBjO6BDfWVPje4Z0EOXwM2JTTEOOc2fIYdIgtTozKnFRL5mC7GTvDoe8oUzmYbWORJopyEkPHX1YBBm/rr8ZjKFJ8pqm5TlrGc1yv290SlPgjVUhYykmQpXSrFFGgnshSQWKlecaKPuDs4fuboYI5z/oOw5YZU4sQ8k4kkzK2Km7Nv3tfTrEWTqc+5rELlm5SmLbuErCgR7MCqLsm98a9zNDfIQf0hXzASDYd9U+c0O7z55k=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b9e0efc1-ee5a-4f9e-69cf-08d82efec6ec
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2020 11:51:46.9446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gs4soVbMsA8GIIJ+35O5cuKLIKNcPTMYfZyU4mloNvEAbaQFy5Zpd46TDUwmUtYD+yqh9Hw4wA3PMMnm4bPZtUkyox4YRwGclazR+Msm27Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3863
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 23.07.20 13:12, Robin Gong wrote:
>> On 2020/07/23 17:04 Frieder Schrempf <frieder.schrempf@kontron.de>
>> wrote:
>>> Hi Robin,
>>>
>>> On 30.06.20 15:31, Robin Gong wrote:
>>>> Add 'fw_loaded' and 'is_ram_script' to check if the script used by
>>>> channel is ram script and it's loaded or not, so that could prevent
>>>> meaningless following malloc dma descriptor and bd allocate in
>>>> sdma_transfer_init(), otherwise memory may be consumed out
>>>> potentially without free in case that spi fallback into pio while
>>>> dma transfer failed by sdma firmware not ready(next ERR009165 patch
>>>> depends on sdma
>>> RAM scripts/firmware).
>>>>
>>>> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
>>>> Acked-By: Vinod Koul <vkoul@kernel.org>
>>>> ---
>>>>    drivers/dma/imx-sdma.c | 13 +++++++++++++
>>>>    1 file changed, 13 insertions(+)
>>>>
>>>> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c index
>>>> 5411e01e..ce1c83e 100644
>>>> --- a/drivers/dma/imx-sdma.c
>>>> +++ b/drivers/dma/imx-sdma.c
>>>> @@ -379,6 +379,7 @@ struct sdma_channel {
>>>>    	enum dma_status			status;
>>>>    	struct imx_dma_data		data;
>>>>    	struct work_struct		terminate_worker;
>>>> +	bool				is_ram_script;
>>>>    };
>>>>
>>>>    #define IMX_DMA_SG_LOOP		BIT(0)
>>>> @@ -443,6 +444,7 @@ struct sdma_engine {
>>>>    	struct sdma_buffer_descriptor	*bd0;
>>>>    	/* clock ratio for AHB:SDMA core. 1:1 is 1, 2:1 is 0*/
>>>>    	bool				clk_ratio;
>>>> +	bool                            fw_loaded;
>>>>    };
>>>>
>>>>    static int sdma_config_write(struct dma_chan *chan, @@ -929,6
>>>> +931,7 @@ static void sdma_get_pc(struct sdma_channel *sdmac,
>>>>    	case IMX_DMATYPE_SSI_DUAL:
>>>>    		per_2_emi = sdma->script_addrs->ssish_2_mcu_addr;
>>>>    		emi_2_per = sdma->script_addrs->mcu_2_ssish_addr;
>>>> +		sdmac->is_ram_script = true;
>>>>    		break;
>>>>    	case IMX_DMATYPE_SSI_SP:
>>>>    	case IMX_DMATYPE_MMC:
>>>> @@ -943,6 +946,7 @@ static void sdma_get_pc(struct sdma_channel
>>> *sdmac,
>>>>    		per_2_emi = sdma->script_addrs->asrc_2_mcu_addr;
>>>>    		emi_2_per = sdma->script_addrs->asrc_2_mcu_addr;
>>>>    		per_2_per = sdma->script_addrs->per_2_per_addr;
>>>> +		sdmac->is_ram_script = true;
>>>>    		break;
>>>>    	case IMX_DMATYPE_ASRC_SP:
>>>>    		per_2_emi = sdma->script_addrs->shp_2_mcu_addr;
>>>> @@ -1339,6 +1343,11 @@ static struct sdma_desc
>>> *sdma_transfer_init(struct sdma_channel *sdmac,
>>>>    {
>>>>    	struct sdma_desc *desc;
>>>>
>>>> +	if (!sdmac->sdma->fw_loaded && sdmac->is_ram_script) {
>>>> +		dev_err(sdmac->sdma->dev, "sdma firmware not ready!\n");
>>>> +		goto err_out;
>>>> +	}
>>>
>>> I tried your v10 patches on next-20200722 with i.MX8MM and it mostly
>>> seems to work fine.
>>>
>>> When I tried first, I had the imx-sdma driver compiled into the
>>> kernel, so it didn't load the firmware and fell back to the ROM scripts.
>>> With this, SPI transactions work just fine, but I got the above error
>>> message printed continuously when sending data in SPI3 via spidev.
>> That's caused by you didn't load ram firmware as this patch set described.
>> Please follow below steps to load firmware manually if you don't want to use
>> NXP official Yocto release package:
>>
>> 1. Get sdma firmware from below linux-firmware and copy it to your local
>> rootfs /lib/firmware/imx/sdma.
>> https://eur04.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ffirmware%2Flinux-firmware.git%2Ft&amp;data=02%7C01%7Cfrieder.schrempf%40kontron.de%7C08276b76f9a14dae1f8408d82ef94da1%7C8c9d3c973fd941c8a2b1646f3942daf1%7C0%7C0%7C637310995564511410&amp;sdata=YA1455ILoNgRDHAOy1H2051J9cu5VsHk39xtQive8mo%3D&amp;reserved=0
>> ree/imx/sdma
>> 2. Load firmware manually:
>>          echo 1 > /sys/$DEVPATH/loading
>>          cat $MY_FW_DIR/$FIRMWARE > /sys/$DEVPATH/data
>>          echo 0 > /sys/$DEVPATH/loading
>> Please refer to Documentation/driver-api/firmware/fallback-mechanisms.rst
>> and load the firmware in 60s (firmware fallback loading timeout) from kernel
>> boot up.
>>
>>>
>>> When I build imx-sdma as a module, the firmware is loaded correctly
>>> and everything works as expected.
>> I guess that's not related with sdma building as module. If sdma build as
>> module, spi will fall to pio mode at spi-imx driver probe phase so that the
>> above warning log never to be walked. Would you please add some debug
>> info to double confirm?
> Hi Frider,
> 	Please ignore this comment, since there is -EPROBE_DEFER checking
> , so you load sdma firmware by building sdma driver as module instead of
> the above comment I mentioned?

Yes, correct.

> The warning log comes out during spi
> transfer start and sdma firmware loading done, but if sdma driver building as
> module could ensure firmware loading done in sdma_driver_probe_phase->
> spi_imx_probe_phase, which means sdma firmware loading has been ready
> before spi transfer start, hence no such warning message.
> 
> But I am not sure if all client drivers except spi are in good shape to support
> ' CONFIG_IMX_SDMA=m '.

I'm pretty sure that CONFIG_IMX_SDMA=m is supported and common. 
Otherwise it wouldn't be an option in Kconfig.

> Besides, do you think 'dev_err_once ' instead of 'dev_err' is okay for you?

I can't really judge if this is a proper fix as I haven't looked at the 
code in detail, but if you want to use dev_err_once(), that would be ok 
for me, maybe even better dev_warn_once().
As chances are that even without firmware transfers will work a warning 
instead of an error makes more sense to me.
