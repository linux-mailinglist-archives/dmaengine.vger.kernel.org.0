Return-Path: <dmaengine+bounces-311-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB997FDB6E
	for <lists+dmaengine@lfdr.de>; Wed, 29 Nov 2023 16:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E88341C20921
	for <lists+dmaengine@lfdr.de>; Wed, 29 Nov 2023 15:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207DA381A6;
	Wed, 29 Nov 2023 15:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bu7styHb"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2080.outbound.protection.outlook.com [40.107.22.80])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713681BF;
	Wed, 29 Nov 2023 07:31:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R+0V1DTmHtYTHXUlKVKOIIg22u6aQjmlbJVt6vCWmzgyFdLVnkP+0mRi0yX3cGucf43bVywoF6e1QIoGPcZEvVuyHVodAjMS5L4ccrAJX5nv9Qt3G7Q48wf5OlC64TKpwPJT4JGU0sUCAlf1nwaU9aqHLxOk8JzdjTUzs9+xeZZlhJ1FlxPEuhVOfumG7h1vJEmx8+cf/ETbDiCRmsQg1/sNrzIMb/g/uHbN82Zedwv97I/wPEhcr7fcEvH0sgbtMooQoq1az6zE7scn2AZ8dBeqjNC7MqvuSCw7OZGFOYRGL3OlBOPn+iMZOJNiVBsjMFw3XfMY5gF6uIRgE3eNXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VnBqjsmxJt3HsXAClsu66jzYa8yBuNKiPc+IqbwRAhE=;
 b=VIh2fW9dawRLIdSezCRTa9yaZ+DqYlPqFmGS0iFqVdphGnLg2ooDAy2ew3LGyDc7iPhq8c1JIR8a7xsW5uqV5963xkFWOxN663a1y8WCwnxr9h8imijoiVFkTWKefnXsS+fDDTXdrKXJpm8Xoew4+I+sWP4LaedkjTu3y+r447f95Ml2hVvQkiVS6ov030cE9wDyjUU0ZIwHH+5IqHAPs8M939W1/clS2F5LKauxuC/1YzFKE43L1Im85O2QvTEF8b6Zf0Ezf62LcaK+eB7j4IGOmdrntuOhWVoJWepDGRIYu9kHACRsSAyfyNZoBjJlEFDHUc4HpRkqQgtqqT1yIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VnBqjsmxJt3HsXAClsu66jzYa8yBuNKiPc+IqbwRAhE=;
 b=bu7styHbZVIXcNgmsuky4uMQM2p7feyCkHpNklLBO5pnX83uLyS7307hOgGAwZSr1kV4F54YuB80FFxKIA6DU9Di3JLn731ynaGceUSbdk+LzPdvuelg5iAZCDbPipMwZE4iubk7ZcCSvvlEEVApYEj6/U8BLOa5NIRILprYm20=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB8818.eurprd04.prod.outlook.com (2603:10a6:20b:42d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Wed, 29 Nov
 2023 15:31:07 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%6]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 15:31:07 +0000
Date: Wed, 29 Nov 2023 10:31:00 -0500
From: Frank Li <Frank.li@nxp.com>
To: wangxiaolei <xiaolei.wang@windriver.com>
Cc: vkoul@kernel.org, imx@lists.linux.dev, dmaengine@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: dmaengine: fsl-edma: dmatest timeout
Message-ID: <ZWdZNIsJGTJazZHp@lizhi-Precision-Tower-5810>
References: <64cde245-0e53-6559-0a3b-ffe0a5415519@windriver.com>
 <ZWYJgc/S8xMofmWw@lizhi-Precision-Tower-5810>
 <ZWZiY4Cy/GP8L+Px@lizhi-Precision-Tower-5810>
 <c9e3d4ae-4c2f-4f3f-14ff-35dd2318f8ac@windriver.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c9e3d4ae-4c2f-4f3f-14ff-35dd2318f8ac@windriver.com>
X-ClientProxiedBy: SJ0PR13CA0170.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::25) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB8818:EE_
X-MS-Office365-Filtering-Correlation-Id: 001dd5be-63d9-42dc-9309-08dbf0f03481
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+xMLNvFIG/KxDZ3a22fqPpgtLHPr34Vh6t/OlpaAp1FTgAGxGht28bN+kkI2WkUz5FRbW47QKWLFU9B9kmszKbUiDOGFSrd1mnlqDdcfUWnVlm0YUEKIH5+DIN8yYQghSL+4zLmFYkk0FsJX155/CA8AdyF6px4BPFArRUz4aoculQ2V16VelE0h39v2KMKmeaff8WfOCQ5fUqsxjRKrnPrjWxB4nWNcY/ZWTUZIOwJ+oZL6q69fqfz0VT0/vHwz3v8OoSrfKVYUpI6a6lwrcOMlRTynQxeZ4Syfr1lhAQUTh7lUZwvVtjE5EJSSrkYUJaW/iGNMCFY6jssazSnZKWF5+m9reXXxQ60PS62txQ0YsKTwRyFkqZjlE0Z1BCgzUwIYLAspZkmzhZkRSTVM1HFgkXut5EidPuYHfdBxNAXM3t7hZI0WYQ/TMqCRohbFV0ci8Mq1zEEPYBgJ3TZ3kHBKQoOe71UnW4BQ/j+Er8v+B//I+saYti61kZaMLY4SqwScU88EaAWbAJn+31G8E0CjTpr6D8f3i69T0rcGP2YPHYjUatCK3CH9SJQyD0zyBKzjy9nILOq8a8heB05gDG9fNH3YL+MxuArMRd8CINkDTmA9KFKNAvEOwAFCAuv/WnCbcDqm1j0CZ1mW1CTgC7QBBcPpJeGEY2GHU8KX6HI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(396003)(376002)(346002)(39860400002)(366004)(230922051799003)(230173577357003)(230273577357003)(186009)(64100799003)(1800799012)(451199024)(38100700002)(26005)(83380400001)(6506007)(53546011)(52116002)(6666004)(9686003)(6512007)(478600001)(33716001)(6486002)(316002)(66946007)(6916009)(66556008)(66476007)(4326008)(8936002)(8676002)(86362001)(5660300002)(38350700005)(2906002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?vvunwEZhXmsF+5TX+5qIDYOKOhs+jRAo+EVbjMHNVfJwqaCfI1LGSOeLkH?=
 =?iso-8859-1?Q?wpa8Ls2wX/ClySquT8h2EuEk3Ud1K4xotHKXcjmhh8BwlrcdmeeTANrPp6?=
 =?iso-8859-1?Q?D2djbfILHbN6VFi3AsTj+dgVLd+7IYCkPLfq1X0tHK0Up0QH/4dz79o1dY?=
 =?iso-8859-1?Q?/8WW6YEP5PiIWcDJhcGAaZCHF14IhyA0EW/Cu3bDRvuHLS/CjWNBj7Efdu?=
 =?iso-8859-1?Q?ULwGagIe5gyUC8Ew/iLWGGYHCUjVoWnilp8fxQlqC5OgDlp8xbX2X8SPzw?=
 =?iso-8859-1?Q?6xG6+rgPeFD1RSQdNiXouq/SXVYeLJG2LFHEG29Hl1u7/YqNbZf1D8LqIf?=
 =?iso-8859-1?Q?72WE/RNhPdFsyuT63wQjcv1nnbW1GvPPOkfn/cui6lfB3fY1rdOi+0OGfG?=
 =?iso-8859-1?Q?VmY41wsW14Kpr+C3tbbhbhWScqlIenAHFnrzIbz8VI+4HtWgd9+ZrA5vuX?=
 =?iso-8859-1?Q?n7r8r75UtCKV9F2L23m8nkqFfnZoCIX2fBOB1Pp5OQI0oN1X1Ox0tu2pok?=
 =?iso-8859-1?Q?70Lboln+jhezte6pe8PQ2BRriRBLc8T+I3DBMja1qcU5fWganNCLJTvzBJ?=
 =?iso-8859-1?Q?+SzFU6ciYNwB8efU7xNzQli4FxIfa1eeeveHICLwpKX6xoTCGEkUXSGiY0?=
 =?iso-8859-1?Q?To89GgBnZpUKx6byoZrxOlMRUFVHRA3NqvEebtLjFtOI0QtpDQkVek8jHL?=
 =?iso-8859-1?Q?UI9bfQ4u3IapRlzlo+W7RrMnMrMI2+A12kbqq8diWh7JbyhTgeTCJ8ex5R?=
 =?iso-8859-1?Q?l1egMe5dk5c13azg1zqpHHzK+I/ReQ2AuljXWsOs9+JP5/kkJNQiwgaXAM?=
 =?iso-8859-1?Q?012QJp84zXU/K/AtRV2UFWAnhkw4Mm3olPa0QapRiYJ0SpwYFKvLAAm68R?=
 =?iso-8859-1?Q?KmoRtPBF4zr5w6j09miDwOnBWKlfC9DKrT+jdgBkiavCpQ7ReR2lUFMGLN?=
 =?iso-8859-1?Q?Eaw70I9BCUDfdcBQW93CMdXH38vXaYSwkGWTymHIRQP5LdaHB4AM68VqUG?=
 =?iso-8859-1?Q?rCptNchLcU6LUAdB27hWvfrwF9KoOwfvZ0CnP1zYf/Z1xvtOicANtkpQiB?=
 =?iso-8859-1?Q?2XsvS4OPI+eZDAKB8Wu5W68xc69E32Qmc15j0B3uMR2A7KZqATSUjCjZQf?=
 =?iso-8859-1?Q?0RW6zojR985CouHKv0MzjmrNBlb7VdBa2Ps2EMA+ycia/98kAHn//8Msg7?=
 =?iso-8859-1?Q?s2yvzh54EqL9qMdbBYkQknxSLRbhTrBPFGcDxJs7yJ9XPtEjJA1GTenytD?=
 =?iso-8859-1?Q?zPyP1ksdE8WQZAHoHfyDbsGwjM/Em2H3RgP2VmkbrTpA0IkSbxOegi0SpZ?=
 =?iso-8859-1?Q?XV32n2txzseAP0bxFgUgmzO1nA8qzxeQXZBcWAfLp+7WRFS45h/vCFVB5i?=
 =?iso-8859-1?Q?jalReDOrUhB+ArAq0mBEdB/qyzXA5L7SO+kcI7oS8bsICyg5wX86Tr08dY?=
 =?iso-8859-1?Q?j4dKkTZ0Kn7La3cpaazI1/SPKMqSAGP+WRQpG2qMdFFMgZ214eBNW7dJhx?=
 =?iso-8859-1?Q?vyr+SzizTFGm6f3Q+L20eOcX7ZF7u01J2tDprytq0n2qsTvNg0PEpFrCSB?=
 =?iso-8859-1?Q?Vp68TGo5kqGh7wB6fim0Q0Pd0WHuZceJrtzwG4op3yIpH0kLaNZWQqEdmO?=
 =?iso-8859-1?Q?tt9TibnLdl46k=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 001dd5be-63d9-42dc-9309-08dbf0f03481
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 15:31:06.8415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iCfwxdl6xtldSruLqXpEGw/mxnZA6nwWYG2R8y5EwGZQ4mnnpXSfpy8ymOBhGrB7UfI2F6io83CmXM5ny0iGFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8818

On Wed, Nov 29, 2023 at 11:10:09AM +0800, wangxiaolei wrote:
> 
> On 11/29/23 5:57 AM, Frank Li wrote:
> > CAUTION: This email comes from a non Wind River email account!
> > Do not click links or open attachments unless you recognize the sender and know the content is safe.
> > 
> > On Tue, Nov 28, 2023 at 10:38:41AM -0500, Frank Li wrote:
> > > On Tue, Nov 28, 2023 at 12:43:59PM +0800, wangxiaolei wrote:
> > > > Hi
> > > > 
> > > > When I executed the following command to do dmatest on the imx8qm platform,
> > > > 
> > > > I found that the timeout occurred on the current mainline kernel:
> > > > 
> > > > 
> > > > modprobe dmatest run=1 iterations=42
> > > > 
> > > dmatest use mem to mem transfer. It seldom used at actual system. Let me
> > > check it.
> > > 
> > > Frank
> > > 
> > > > I found that the completion interrupt was not received in
> > > > fsl_edma3_tx_handler().
> > I test at imx93, it works. I supposed it is the same as 8qm.
> > 
> > echo dma0chan0 > /sys/module/dmatest/parameters/channel
> > echo 2000 > /sys/module/dmatest/parameters/timeout
> > echo 1 > /sys/module/dmatest/parameters/iterations
> > echo 1 > /sys/module/dmatest/parameters/run
> > 
> > I add debug message:
> > 
> > [  154.090765] fsl_edma_tx_chan_handler
> > [  154.094711] fsl_edma_prep_memcpy 8d842340 8d839280 7104
> > [  154.100063] fsl_edma_tx_chan_handler
> > [  154.103949] fsl_edma_prep_memcpy 8d8419c0 8d838580 4288
> > [  154.109265] fsl_edma_tx_chan_handler
> > [  154.113235] fsl_edma_prep_memcpy 8d840ec0 8d838340 6016
> > [  154.118573] fsl_edma_tx_chan_handler
> > [  154.122508] fsl_edma_prep_memcpy 8d841c00 8d83a8c0 1920
> > [  154.127791] fsl_edma_tx_chan_handler
> > [  154.131738] fsl_edma_prep_memcpy 8d840040 8d838200 14784
> > [  154.137272] fsl_edma_tx_chan_handler
> > [  154.141171] fsl_edma_prep_memcpy 8d840280 8d838080 15616
> > [  154.146716] fsl_edma_tx_chan_handler
> > [  154.150598] fsl_edma_prep_memcpy 8d840e00 8d838f40 4928
> > [  154.155915] fsl_edma_tx_chan_handler
> > [  154.159858] fsl_edma_prep_memcpy 8d8419c0 8d838040 7424
> > [  154.165203] fsl_edma_tx_chan_handler
> > [  154.169140] fsl_edma_prep_memcpy 8d841700 8d839380 2560
> 
> Hi Frank
> 
> I followed your steps and tested on imx8qm, but the timeout still occurs,
> and the interruption was still not reported:
> 

Which eDMA controller dma0 map to? there are many controllers in qm.
Is it possible irq number wrong in dts?

Frank

> echo dma0chan0 > /sys/module/dmatest/parameters/channel
> [  401.285217] dmatest: Added 1 threads using dma0chan0
> echo 2000 > /sys/module/dmatest/parameters/timeout
> echo 1 > /sys/module/dmatest/parameters/iterations
> echo 1 > /sys/module/dmatest/parameters/run
>  dmatest: Started 1 threads using dma0chan0
> 
> [  452.292899] dmatest: dma0chan0-copy0: result #1: 'test timed out' with
> src_off=0x40 dst_off=0x8c0 len=0x3180 (0)
> [  455.362690] dmatest: dma0chan0-copy0: result #2: 'test timed out' with
> src_off=0x880 dst_off=0x840 len=0x35c0 (0)
> [  458.433127] dmatest: dma0chan0-copy0: result #3: 'test timed out' with
> src_off=0x2200 dst_off=0x2f80 len=0xbc0 (0)
> [  461.505112] dmatest: dma0chan0-copy0: result #4: 'test timed out' with
> src_off=0x400 dst_off=0x22c0 len=0x940 (0)
> [  464.581047] dmatest: dma0chan0-copy0: result #5: 'test timed out' with
> src_off=0x8c0 dst_off=0xa40 len=0x2b80 (0)
> [  467.653415] dmatest: dma0chan0-copy0: result #6: 'test timed out' with
> src_off=0xdc0 dst_off=0x1300 len=0x1140 (0)
> [  470.721481] dmatest: dma0chan0-copy0: result #7: 'test timed out' with
> src_off=0x1ec0 dst_off=0x900 len=0x1980 (0)
> [  473.792990] dmatest: dma0chan0-copy0: result #8: 'test timed out' with
> src_off=0x500 dst_off=0xac0 len=0x31c0 (0)
> [  476.865088] dmatest: dma0chan0-copy0: result #9: 'test timed out' with
> src_off=0xf40 dst_off=0x7c0 len=0x1a80 (0)
> [  479.937155] dmatest: dma0chan0-copy0: result #10: 'test timed out' with
> src_off=0x240 dst_off=0xc0 len=0x23c0 (0)
> [  483.013144] dmatest: dma0chan0-copy0: result #11: 'test timed out' with
> src_off=0x6c0 dst_off=0x940 len=0x2e00 (0)
> [  486.081045] dmatest: dma0chan0-copy0: result #12: 'test timed out' with
> src_off=0xe40 dst_off=0x15c0 len=0x2a00 (0)
> [  489.153248] dmatest: dma0chan0-copy0: result #13: 'test timed out' with
> src_off=0x700 dst_off=0xc00 len=0x2640 (0)
> [  492.226221] dmatest: dma0chan0-copy0: result #14: 'test timed out' with
> src_off=0x1b80 dst_off=0x1740 len=0x1840 (0)
> [  495.300954] dmatest: dma0chan0-copy0: result #15: 'test timed out' with
> src_off=0x980 dst_off=0x140 len=0x34c0 (0)
> [  498.373058] dmatest: dma0chan0-copy0: result #16: 'test timed out' with
> src_off=0x14c0 dst_off=0xe80 len=0x100 (0)
> [  501.445433] dmatest: dma0chan0-copy0: result #17: 'test timed out' with
> src_off=0x880 dst_off=0xc80 len=0xe80 (0)
> [  504.513108] dmatest: dma0chan0-copy0: result #18: 'test timed out' with
> src_off=0xc00 dst_off=0x3b80 len=0x380 (0)
> [  507.585497] dmatest: dma0chan0-copy0: result #19: 'test timed out' with
> src_off=0xd40 dst_off=0xec0 len=0x2c40 (0)
> [  510.661497] dmatest: dma0chan0-copy0: result #20: 'test timed out' with
> src_off=0x880 dst_off=0xd80 len=0x24c0 (0)
> [  513.729262] dmatest: dma0chan0-copy0: result #21: 'test timed out' with
> src_off=0x1080 dst_off=0x1680 len=0x22c0 (0)
> [  516.805534] dmatest: dma0chan0-copy0: result #22: 'test timed out' with
> src_off=0x11c0 dst_off=0x300 len=0x2700 (0)
> [  519.873187] dmatest: dma0chan0-copy0: result #23: 'test timed out' with
> src_off=0x940 dst_off=0x0 len=0xb40 (0)
> [  522.949304] dmatest: dma0chan0-copy0: result #24: 'test timed out' with
> src_off=0x3340 dst_off=0x1640 len=0x400 (0)
> [  526.021006] dmatest: dma0chan0-copy0: result #25: 'test timed out' with
> src_off=0x1b00 dst_off=0xc80 len=0xdc0 (0)
> [  529.089833] dmatest: dma0chan0-copy0: result #26: 'test timed out' with
> src_off=0x24c0 dst_off=0x2bc0 len=0xf80 (0)
> 
> 
> thanks
> 
> xiaolei
> 
> 
> > 
> > Frank
> > 
> > > > I didn't find any special configuration from the manual. Can anyone give
> > > > some suggestions?
> > > > 
> > > > 
> > > > thanks
> > > > 
> > > > xiaolei
> > > > 

