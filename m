Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23F312416ED
	for <lists+dmaengine@lfdr.de>; Tue, 11 Aug 2020 09:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbgHKHKv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 11 Aug 2020 03:10:51 -0400
Received: from mail-eopbgr10102.outbound.protection.outlook.com ([40.107.1.102]:32426
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726792AbgHKHKu (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 11 Aug 2020 03:10:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mo+MxBgtGvfXxBNnWTq+FotrXuyAcvd1pXXZpvNBQ0jLx2JgZjt18quAonb1VBGHmzoETyx2/5/HXqAa+WTUMqxyFNw4NVerbSaq233vEDO60Lb03OUv9x0ySf1q4YORIpX6rn1cyFngedahQKGcRtjOMV2k48RzCLotpArgDTBH82H550ET6ugBvGJCJb+mCsSu99qIPzWja89QWpMQnO4JL0LaIslXLYcQqPAoToR2bpvv3q0LW1RrZ9FU4NOc5MfHRz/PXxEkxdMCgVpK7oJxinZipYZi7V2qeaaDcEx9gwb0M3I+kTP8UpJx7Jh9Anyt2sxl6Ys/itNIRBkWwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B2mhbkkVV7ZcSHcIK0bzQclRLmTqSP5nMkh8DJZxcBc=;
 b=j7e18hCO3HnoJSKRFo0QxODeiizz5+lcVHTofuuRdM7dZt0/v64YjzpA3jbXWP38xIPvKmdc+pnAm+vJq/yztTtUFoSaJjb5WX1ECld/BItvyzWMEHrWITmZRMQrZiD/7BX1G3bHjIsRECRy5eEpzjsG2Qs6WmN4unIOXAzMoTun4TYBOIXLZkKalb5nk+PpTxOiEjiwNy8STmsH9bmgJAkSNjDkLZRU9eTC0uw7pRt1E9qHWMQVCFUYBoxKrUj5yPQefbeqS3lezpJDzQ40/DIu5xzx8cHtbbSmY6zfz40nWbmywMlo0Icweuxw0HUY6IEJSwa0CumOfvFYQuH8xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B2mhbkkVV7ZcSHcIK0bzQclRLmTqSP5nMkh8DJZxcBc=;
 b=aDbVPCjgu0gR/2WtK8z43QUQBWQz0skameRns3+lWEaFnYPofag2yr/zvC2WWWmVBlFiKVQQ0uX5rfowygu3poqejrz6HEbMSwzz+hH/yHNZ5DyfFEHkoPkS8lhYnrdDdTU3RPr7OgH4VnKY6ebUDBggjUAOsyO25VRLg9bvi5g=
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=kontron.de;
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:157::14)
 by AM8PR10MB4241.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1ee::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.15; Tue, 11 Aug
 2020 07:10:45 +0000
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::51f5:dfc0:24bb:309c]) by AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::51f5:dfc0:24bb:309c%7]) with mapi id 15.20.3261.025; Tue, 11 Aug 2020
 07:10:45 +0000
Subject: Re: [PATCH v11 12/12] dmaengine: imx-sdma: add uart rom script
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
References: <1595616685-9987-1-git-send-email-yibin.gong@nxp.com>
 <1595616685-9987-13-git-send-email-yibin.gong@nxp.com>
 <89946dc6-6c0f-b3d5-9c9a-517f1ed7b5e1@kontron.de>
 <VE1PR04MB6638F057BC8F7F38E954316F89440@VE1PR04MB6638.eurprd04.prod.outlook.com>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
Message-ID: <0f20e018-81e3-46ae-0a56-bf245a7790c5@kontron.de>
Date:   Tue, 11 Aug 2020 09:10:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <VE1PR04MB6638F057BC8F7F38E954316F89440@VE1PR04MB6638.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR07CA0033.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::46) To AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:157::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.99.60] (80.147.118.32) by AM0PR07CA0033.eurprd07.prod.outlook.com (2603:10a6:208:ac::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.10 via Frontend Transport; Tue, 11 Aug 2020 07:10:44 +0000
X-Originating-IP: [80.147.118.32]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26148fb4-8026-45c5-0e2e-08d83dc5aac1
X-MS-TrafficTypeDiagnostic: AM8PR10MB4241:
X-Microsoft-Antispam-PRVS: <AM8PR10MB4241AA8E30B9D9BEBA7C33E0E9450@AM8PR10MB4241.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 79wCSmH/3uK63iP7R1nM5fMbnJZUdhL8+TqKWK04Df49AqY9kP03C89oIabZGBk58WMqzZ7pKgcAsrnyb/dL0Ialk3UkbCQN/3rtL86YutQ0ie7tJTbVj17UV4C7dKSWGFGiiKQO37J/y0nhDrd2tEzgD0d+lN9axeV5SAh7Dql3DOQJ0YMHA0YA70kVFB/R8+lK4RYmSom/TeNnvuni193UDSTjex4Lag5vE2RBwxgGvXmP+wD8DFnpGqNTEzSxyqL32msW5A4a+9/kMgRdCugcJX/eMxj7CCfSaMvGRVoX3f3LzdTn2ZN6eHueF5379T44seouiUGmmRhkYvdqda7DskNsC7EuiGX1WxuMsz1Sw1+aAzi6iD5l0U23Q7Q4w/oRkVJQc/wUeO/p0h9YrQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(396003)(136003)(39860400002)(376002)(366004)(52116002)(66476007)(66556008)(6486002)(31686004)(86362001)(5660300002)(8936002)(53546011)(4326008)(36756003)(66946007)(316002)(186003)(16576012)(16526019)(54906003)(110136005)(26005)(8676002)(7416002)(478600001)(2906002)(956004)(31696002)(2616005)(44832011)(921003)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: ZwLizx8t/s4X03WRDN3M1Xa+fPynh3NwW1mU/X4YNuqqg+YrXQkKxdnxtOii7cS4glYP2u49kUJyVJEYSnse8vdRZsA5rnY/+PviU8tSlRANVr+DTpDSwJ1usjfdwkBxMoUaJJqwRoeIU4+AQyqNUQdVGL7VK+fQTl8LMNRGqo4epTd6qAkjOjO9+00SaRYSoIeX5M1A2qXcPyeOqXpOf+6ra1TFLD2+LOovOZAkl5MprsFd80okJlwYKO2BqXRSAr9xBZSPRUjvnjQkZdYW8Lda0nnYcaoUEwFwD3aED52MqgvHfU/Vsm2NjFNr3ZxhsolNpBWTTUfi9t+b+gR2R5wAdyjRXjmrKMR8mapjO11O4ga4aackhu3j5N4k0WI8ismmSLDo2OQdRMY6GFuZ7Uas8Jc+trUaPWhitGLe4UxZTekjcBggKlEgHLjpRA66fkXCPiv09HyBPGy2gKoghmRyQ5foWqMzGeOpAjDoiI6d2qblQ28+wWhVocQLdmZ9OuzpZ/JljKAbJYutSkI7fWV181GfX+LcrXk7KNTlPwbzV2/RWo9flr5rcZouxPe1XTW1+F5Cs+TiW92gCya37K4PN/SP5HzW9x1jqYMMvfUY6oNVi9OgNSQD0ggFPq0nB2aEh1XNETH6ved2bWV39A==
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 26148fb4-8026-45c5-0e2e-08d83dc5aac1
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2020 07:10:45.7134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mvJk+VR2iyUKsa+wiJ8TSmlfvFcEfM3e9MaAnTma2Z3fgdvHtk1BXWMtQLinE11cTAZ2XvBPROYuCpxy5IsdXAzec/Y49yssqktEEMekc30=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4241
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 10.08.20 12:57, Robin Gong wrote:
> On 2020/08/10 15:33 Frieder Schrempf <frieder.schrempf@kontron.de> wrote:
>> Hi Robin,
>>
>> This patch seems to break UART DMA in case the ROM firmware is used. In that
>> case sdma->script_number is set to SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V1, so
>> the ROM scripts at uart_2_mcu_addr and uartsh_2_mcu_addr will never be
>> added in sdma_add_scripts() as they are now moved beyond the V1 max index.
>>
>> Reverting this patch fixes UART DMA with ROM firmware.
>> Can you please find a way to fix this or just drop this change?
>>
> Hi Frieder,
> 	Thanks for your report, could you try with the additional below patch?
> If that works, I'll merge it into next version.

Sorry, I can't promise to find the time to spin up a test for this 
anytime soon. But the diff looks like it would work.

It would be nice if we could get this patchset merged soon, as it also 
seems to provide fixes for SPI on i.MX8MM. So any help with reviewing 
and testing is appreciated.

> 
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index 5900e32..4db55b9 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -1754,6 +1754,19 @@ static void sdma_add_scripts(struct sdma_engine *sdma,
>          for (i = 0; i < sdma->script_number; i++)
>                  if (addr_arr[i] > 0)
>                          saddr_arr[i] = addr_arr[i];
> +
> +       /*
> +        * get uart_2_mcu_addr/uartsh_2_mcu_addr rom script specially because
> +        * they are now replaced by uart_2_mcu_ram_addr/uartsh_2_mcu_ram_addr
> +        * to be compatible with legacy freescal/nxp sdma firmware, and they
> +        * are located in the bottom part of sdma_script_start_addrs which are
> +        * beyond the SDMA_SCRIPT_ADDRS_ARRAY_SIZE_V1.
> +        */
> +       if (addr->uart_2_mcu_addr)
> +               sdma->script_addrs->uart_2_mcu_addr = addr->uart_2_mcu_addr;
> +       if (addr->uartsh_2_mcu_addr)
> +               sdma->script_addrs->uartsh_2_mcu_addr = addr->uartsh_2_mcu_addr;
> +
>   }
> 
> 
