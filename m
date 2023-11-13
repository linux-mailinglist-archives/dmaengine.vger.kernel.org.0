Return-Path: <dmaengine+bounces-91-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CFAB97E9FB6
	for <lists+dmaengine@lfdr.de>; Mon, 13 Nov 2023 16:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57FD5B208C7
	for <lists+dmaengine@lfdr.de>; Mon, 13 Nov 2023 15:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E5021358;
	Mon, 13 Nov 2023 15:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WFiw/gYc"
X-Original-To: dmaengine@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2F721109
	for <dmaengine@vger.kernel.org>; Mon, 13 Nov 2023 15:15:39 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2075.outbound.protection.outlook.com [40.107.7.75])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5C8A4;
	Mon, 13 Nov 2023 07:15:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hTfIyFfhl2Pi2uFJmFh4uaPP+NMZpn4mYTAi+vAwCzTe4aGSMcPCxVgWdfuJPREMzOGyTTqrGgJm9lJrOWaKQtegA1C72it1aUeSGXm6AuIvZtuteU/fsTgfzPGRot7/qlG2P0u+wv/HGA1amFCNgryVIwwIA6mMEyh0wAtTI5aRfHMZoBQFrGAV1dd2waYchErprpEoamgkUX73g8QN1gr68msdtQINmcxwTlnmPi6biozbiCu61y9XaG9HUf1G7MepBkfJ0Y0+vgn9TrqJOvoV0z9S/zymaIlk4Y2BFWxFsRoNkNYQxTs3xyEKgdaipVu/zLGfwVivR7QKDOGcjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oO96kE0hPAm7jlLwhxESuzhHCi7KnN8jcc7yzhLr5VY=;
 b=cF4B2mmIZwL3ZAS0UDEzZbFdSOntjfpl0FvpIZx3N+lyDr8kCzt9zQkYMFPpi+XF+7aUWP39i5PE/Ss53OmTnLSM3UmAi2rmgwOBlRTR8hrF024N66oLkU5ppzh8IUwqLwIl0rlAC2afiWpKBqddwukLwFUiS5USs3brVwSbkjmhN0hcQSF/miHRvCK+lZbvvYIC0uAW+fE8uErycxPOqdqb4GYvd1abCcC1y+odPpr8ojuy8ippxqmKEhYiD7aQhib7j4XXvLnwjFX0gcJKxjpvTIB0UQejm3fnH4XWQZYal9Q5gJGT+RgYwO/Mm/kUCkCl7ZcEOwaTBsBQeSwjiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oO96kE0hPAm7jlLwhxESuzhHCi7KnN8jcc7yzhLr5VY=;
 b=WFiw/gYczs6NIgra1iKnpgGpha9H/+UI4PofNahk+2F3VpH4g8XS2qbxuaYRrAPsKgdDN9Om+fOG/LLRMT79HzDnTOFYj6oqrzV1ZAw7/lhs2fFSlsKxymLtnyrpGDz1NhOGXdqRb5X4WAuV9jx9C1HRe3QMwlppChC3RzHGjIo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM0PR04MB7105.eurprd04.prod.outlook.com (2603:10a6:208:19b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.15; Mon, 13 Nov
 2023 15:15:35 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::bc7:1dcd:684d:4494]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::bc7:1dcd:684d:4494%4]) with mapi id 15.20.7002.015; Mon, 13 Nov 2023
 15:15:35 +0000
Date: Mon, 13 Nov 2023 10:15:27 -0500
From: Frank Li <Frank.li@nxp.com>
To: Xiaolei Wang <xiaolei.wang@windriver.com>
Cc: vkoul@kernel.org, imx@lists.linux.dev, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dmaengine: fsl-edma: Add judgment on enabling round
 robin arbitration
Message-ID: <ZVI9jzr7LxkTozWW@lizhi-Precision-Tower-5810>
References: <20231113131105.1361293-1-xiaolei.wang@windriver.com>
 <20231113131105.1361293-2-xiaolei.wang@windriver.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113131105.1361293-2-xiaolei.wang@windriver.com>
X-ClientProxiedBy: SJ0PR03CA0249.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::14) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM0PR04MB7105:EE_
X-MS-Office365-Filtering-Correlation-Id: 94f98cee-f5ee-4e86-283b-08dbe45b62ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QvjS44VASo8ffKBgVgpxaUEVKhv9fqmmLFMPGi3fF8lvs7iZwQxrOcNiYol/ARwTGF1LtieRxl9qFCAn3iF6pgiqb9v4oSImLN1ojpHZv1bBgc1P7m9wQsrO618eDDKfI0MjKpCvH/M6/HdtQIwuxMm6xEWPoirzOP4lw8sedfc7Y6tJy3zBmMdaM4UAEiva3woUF3Nhl/G4VXFcO2pRlpk8nfCh7seYxA0/IDTiADtNtEcbW5IRqfurIqTUxehQ3wlxOi2EtSjVL7VD+tweUUXaY6tUMEYmh5yf3KsDcDuaM/1pi4TtcOHZL04281KL3NOZl5RP8dGjOcRn8V4A1UIMejbGdpudvC9iSgN+7mFIRhN+stGEPXhcbV3VlbJnkys9NJFlXd8U5YMSzhmErGZ36SDTFKfWQCpiqB39HhIc9IwmGyrRWRBKGEjOfi6UuctCeWOls35o+OKZBN8v6W4wUs/I+0upNHWaRTrNxSwn8CZ7bvVNL4wZ6k837FKK+HItd9aZ2sFQqdHVm1yDhRIbd6JzKEeaxWCAVe60d0F0LfKM/MGRnDY75h8vbE2nSurZS3IvG4EcuSG5++g5qCf7Q32tmxtcbxcaBkf5gwhmCCiC9OCpvIBsyCdBwzJW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(396003)(39860400002)(346002)(136003)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(26005)(33716001)(52116002)(6506007)(6666004)(9686003)(6512007)(83380400001)(5660300002)(4326008)(8676002)(8936002)(41300700001)(2906002)(6486002)(478600001)(6916009)(66476007)(66556008)(66946007)(86362001)(316002)(38100700002)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qyMfo9+mQjGiIy7iEyWaIWL/JI/Ywzm09b+oWxs6oIDMJ83zGk/yUbF35TaS?=
 =?us-ascii?Q?NZup/vDgYl/bnREhAl7Abb2prOfHSuNOg65wJjT3F8dMNxRWj78MzxxqdMGw?=
 =?us-ascii?Q?eKT5asOkekuTR/JdXwm/3QED2e4dSQP56KflViBAuHlVJtHwFNnF0YqeWIym?=
 =?us-ascii?Q?GrBXwWjBcamo2Vdb1R9sckyjcxYhg8HBgjJBltl8x9HeHwHfTHrvonJkHpn2?=
 =?us-ascii?Q?JC1sKGakc8TyQdmEOaOfHqatoGfjQf3N0IOdovTMUEPNbPke16BJYiYTyTAR?=
 =?us-ascii?Q?9HQ0hNTPnHbzrYzme35Lke3EvYY3IsKOs/4DOBweGtwu7Z/YqrNSU1QoR4PM?=
 =?us-ascii?Q?Fk74LdPTBz9QJ+vzDWccbalNmtm8UY90uYq9+kkYNRb/PdFygukL/gTNt5zs?=
 =?us-ascii?Q?tsvWP284FNgkQVnieDOK8Vyhg8PhOlmjhSY8UHi3a9nxMj4fVULI0HzHtyhP?=
 =?us-ascii?Q?IZzzrIvBCOSAY5m+IJbz5rBJZ0EkEaEx1KIzC9aqgk8W2qcQgppc4on7U/JC?=
 =?us-ascii?Q?YwuRvBYD1FHgGr2r62k8AcXeqXW3Sc81fnto1jfXopEoQholc8ZUIQI8NpyO?=
 =?us-ascii?Q?FH9IHMtvm4KVHzFT/3eNm59XkuIXddZRie5bdXqD7q9skPtCDMcFlIAj8yAw?=
 =?us-ascii?Q?varao24qbyqRX0HiWeH9b9uzw06jj4nzGQcsIDKdVBKgy+R8wWxqpnRwelv9?=
 =?us-ascii?Q?G4/Z4AJ7muyd/L0G99gb9tR0urBmv3oG4KM2CTL39g8Q1c7kfb3ZATmoM9nI?=
 =?us-ascii?Q?oYFROBw6D4ayZn9F7mYNHoxzdnDQ6gagq34CLDoU+qU995JLO6yv5Mb4CmH2?=
 =?us-ascii?Q?ba+/lFF7+DEkUQF9GMLPufGQ9SiH2sThHSIJMD3VauJj19kjJrl70zWIZLnn?=
 =?us-ascii?Q?Le/qi8gdI3aAbGOHB/5Bi3VKSdczNIg/Idw62zuynusbbz1D34BQ/pgl2wMk?=
 =?us-ascii?Q?LbGXCJUmWU33WsXNX4q8VSUIuh1/F+2wfWg3Gun90vA87ZgLxjc+AT3YTDSS?=
 =?us-ascii?Q?2VxBHt/5DxKWmG093LfpAxabPDkC3IVNaTeyLFnN4+Xhcwh3kgEMoRf0LEyT?=
 =?us-ascii?Q?tVPCWHxCG3YHmdqka26ojvyleMnRpJ/fEACN1Lsy+9EWjiiDB0qru4gW3Juq?=
 =?us-ascii?Q?an13NZ61VZEP2JwNYm3fzRr71VWIolz/yCX28JjoplSTExnUO4/03XVng7Xh?=
 =?us-ascii?Q?s531G8hBTNUZsSzdUGtASyu2dR6A7xnj8uUIDjV3uV6/bWufWtawPAWn39QA?=
 =?us-ascii?Q?O8l8kDFLze+8TJtJfmmDOoQddot18gfwdQg/70qOxsHLbkxnq45X8NOCNbRS?=
 =?us-ascii?Q?gKpMC/Qx0iBlLYQfbxZBKFIwgRb6zuVQZ9iAXtNuobVewL85fFasU3QnleH7?=
 =?us-ascii?Q?WHnds6uHhBpzyf56k7aCU39J2o3cmeVuIBslDb+jVPW2TRopKH3xWu4m8RrA?=
 =?us-ascii?Q?APyhNOtNJpAVwiaQOGu+Gdekk7a1HDqiWV+wiVsB/lj56zYIJ+ukgAggM+ZC?=
 =?us-ascii?Q?FIJvL+pb9tdkw5ie1rJMzvXCmkE57e/c7GckM/PacFxAZVam66dY+oq84InQ?=
 =?us-ascii?Q?FYGJDsKD3rQIc9GlfJA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94f98cee-f5ee-4e86-283b-08dbe45b62ea
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 15:15:35.7196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C0HKP+TT0FnolsQvxPCVg8neC+m/PX44gteu5slYlt0j5QFZUcdO1cxV/8cassIOYalVwZ4t7i+Q1mDn6LodDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7105

On Mon, Nov 13, 2023 at 09:11:05PM +0800, Xiaolei Wang wrote:
> Add judgment on enabling round robin arbitration to avoid
> exceptions if this function is not supported.
> 
> Call trace:
>  fsl_edma_resume_early+0x1d4/0x208
>  dpm_run_callback+0xd4/0x304
>  device_resume_early+0xb0/0x208
>  dpm_resume_early+0x224/0x528
>  suspend_devices_and_enter+0x3e4/0xd00
>  pm_suspend+0x3c4/0x910
>  state_store+0x90/0x124
>  kobj_attr_store+0x48/0x64
>  sysfs_kf_write+0x84/0xb4
>  kernfs_fop_write_iter+0x19c/0x264
>  vfs_write+0x664/0x858
>  ksys_write+0xc8/0x180
>  __arm64_sys_write+0x44/0x58
>  invoke_syscall+0x5c/0x178
>  el0_svc_common.constprop.0+0x11c/0x14c
>  do_el0_svc+0x30/0x40
>  el0_svc+0x58/0xa8
>  el0t_64_sync_handler+0xc0/0xc4
>  el0t_64_sync+0x190/0x194
> 
> Fixes: 82d149b86d31 ("dmaengine: fsl-edma: add PM suspend/resume support")

It should be 
Fixes: 72f5801a4e2b7 ("dmaengine: fsl-edma: integrate v3 support")

FSL_EDMA_DRV_SPLIT_REG is added at above commit.

The same to the second patch.

Frank

> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
> ---
>  drivers/dma/fsl-edma-main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
> index 52577fffc62b..aea7a703dda7 100644
> --- a/drivers/dma/fsl-edma-main.c
> +++ b/drivers/dma/fsl-edma-main.c
> @@ -665,7 +665,8 @@ static int fsl_edma_resume_early(struct device *dev)
>  			fsl_edma_chan_mux(fsl_chan, fsl_chan->slave_id, true);
>  	}
>  
> -	edma_writel(fsl_edma, EDMA_CR_ERGA | EDMA_CR_ERCA, regs->cr);
> +	if (!(fsl_edma->drvdata->flags & FSL_EDMA_DRV_SPLIT_REG))
> +		edma_writel(fsl_edma, EDMA_CR_ERGA | EDMA_CR_ERCA, regs->cr);
>  
>  	return 0;
>  }
> -- 
> 2.25.1
> 

