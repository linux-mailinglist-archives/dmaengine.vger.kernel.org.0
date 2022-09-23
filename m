Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987BC5E77EB
	for <lists+dmaengine@lfdr.de>; Fri, 23 Sep 2022 12:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbiIWKH1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 23 Sep 2022 06:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbiIWKHT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 23 Sep 2022 06:07:19 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7202C132FEC;
        Fri, 23 Sep 2022 03:07:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jjcDwx6FfdLAJuVcshOBNUOmG1Vxu6qtUAtxIsBJXiwoP1UIBiFsqn01y4SopUItDM5hwq+AbXMurMqp+vKOKaXhGVqCBE0r4ZLqBv9tUuLjTGewRTvaSvJFm3zY0PITgkFl37Y1yVjSPJzXPVtZsKDrcN7y/6mS1Imyhqdr8hsUswxtEIxLt3EJOKA0V/M0qSqN3xDm9mIVzdhwTzkU+OPgB1TvidkCaNRvqVow/oNeRBG7rYIuuCBsRComo2SWUPGPMbBhZ5szogFZgzBfsVPc2wewTALoYu1grsJ7LpYthD1kH1X28f1521m1BZl3AzZ1aV6hposu3WEMHJ+sYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yDD1phFEXIXLwmjDL8LGNKu+PdRUbq676MO6k3OScaE=;
 b=CFcHJl69nACpZP6XunjxaXO6ycy51CsHKC0momUzBpmNKuuOLdWeQxLNiKcZk/PfwbOgEQxvnlY4wpN1PHGUIELiw27RCxez/PJGR588UuqhInyGDXeKnshI0UytZ5ZRZoer79KCZjxyA/ttXwWH8x+jthLUH0Iqb2t8qP+mJNbHgDyNiZk5Fco9bskbl1s9MR2KIY5wGlNWj3zECwme1Pe5dxUEfm2OYyFJ9ukIRjvyYtxzdrrW0BLjef0mbkOQQXQq1zCB6yGPK0ZMe+W8Kdl4HKsW7BJsiJNv4c1O76y7cj3HVGTyNgnR7PjhGNlwV/n2NFNaZL3Zn0ia4tt2Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yDD1phFEXIXLwmjDL8LGNKu+PdRUbq676MO6k3OScaE=;
 b=WujCqVQizubdvRLSAsKYMNnZIDDo/l7QLJR/oxYKrjdVwhyi0zhF2JCPPnvkQUCQbtNkVaXi27fE/avTIh0+ncEvG52rZI9D5q8FWwfykizaoErVvR6NTbAZHX660aN0XW6Bhas7PhhjPSSBB5F7U5JGd5vKfwspCEAjBnIC3c+FSgmn3J1bHtFYxmy3k1/VxxLFs6mMjSVHKcOKxK/4GZEAwKg8A27xHWP2BhU0nHV14MT7lelqzIzbFub/fKkV05nzaJnMVQ2qatbMT6a0Pl6KDYUFOj4ZYp9eBLcXdR1VPG/O7Wc6gfF51g5S7z3xnygz+LLAnTLj6tKllWiqoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 PH7PR12MB6490.namprd12.prod.outlook.com (2603:10b6:510:1f5::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.14; Fri, 23 Sep 2022 10:07:02 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::b07f:53b1:426e:a29d]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::b07f:53b1:426e:a29d%5]) with mapi id 15.20.5654.020; Fri, 23 Sep 2022
 10:07:02 +0000
Message-ID: <77bbe256-f684-04c2-b78f-58bcc89f4755@nvidia.com>
Date:   Fri, 23 Sep 2022 11:06:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/3] arm64: tegra: Add dma-channel-mask in GPCDMA node
Content-Language: en-US
To:     Akhil R <akhilrajeev@nvidia.com>, ldewangan@nvidia.com,
        vkoul@kernel.org, thierry.reding@gmail.com, p.zabel@pengutronix.de,
        dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220919112559.58195-1-akhilrajeev@nvidia.com>
 <20220919112559.58195-3-akhilrajeev@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20220919112559.58195-3-akhilrajeev@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0015.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::20) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|PH7PR12MB6490:EE_
X-MS-Office365-Filtering-Correlation-Id: a8cb527a-359a-4db6-9dd0-08da9d4b5c5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K1Ocxxh21QcUXxh9ibv7xZHeGhxHJL8am//Fb2niiUxVqCsLXTKNn60aYWlY2IwrU2NIn7FFHgsNCh03MnXe/7Mf2dO3gmkU6PEKFl6IrtxZRx0k1bvDnEnV77c+q+iJfygDxzquE3kYO2NErMRks//u1o8BQ/aeiZunQLUZ3O5zkZrpUUIz2B3bS6XpwXq3ZSanDk6vm6w6TC6u9WW+ISdOzhiAbZE8cznLVvlJ6OEJl7USlR6S83Q6BPq8oBv/kXHB1cEXP+qLkIzCDO/vQIB2V3oo6x647z7SLws5ir/uCoq2mLQZf57uxXUMkTcg3VGG4/DhEaHOmw7xPgTzuknnK1Tl5bmVPthMhkSfyrSjjYDVqyOGWzPcRsq2eu1A+V2cPsoEBmTvz5bTiYwj/56X/wCoP3azFJljKAAEyEnUhgohwrB5oTEW/6dyiNZwaKSEFOUruwNshbysSa3PvKzrMusOE7qgE4qoevpaw1GYXFyxbR6hw1m/3lx5+pdhvmzQq5i3szCSAm8GlZekbzMN12HkGVIwcXmvw257E2o5OPGLP6SMRkpEdaJ2iYUd9G2ooIJLzwZqNDO9oOvWMzj1znT8rfpYkzJGkxAy6wFtv3zclxBYppRbTAhin0uGTH8jVfMPId2Q/qE6Teja9IrSfYjtzT169qNesH3XBnHePCQaNmZMV5L0s1hRQCQ5ay9ZbSZSqbCJjLTaVblKaY+A1+ljVSwIJtL0qXSa9xJU/pLk4QhCsKvQmnFUoV4qEV9Vdn7MQuZ3+URD/H3bFByyfQ+3+FRT2tCRxT+dXN0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(39860400002)(136003)(366004)(376002)(451199015)(8676002)(36756003)(31696002)(86362001)(31686004)(316002)(38100700002)(83380400001)(6486002)(41300700001)(2616005)(2906002)(53546011)(478600001)(8936002)(5660300002)(186003)(66556008)(6512007)(6506007)(66946007)(66476007)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2FNTlo5aGgvdmpiSlBaRVl3ajFVSEd3LytMVkJTbWRaSDcyL3IxcWp3RnI0?=
 =?utf-8?B?bWhBSlVKMUhVTWFkNEFaYTlEeGV2SWppZ3kvSnVMRHVSOTVUcmVlMlpsQmxG?=
 =?utf-8?B?MVZvb085MjVOMStMQk5xUjNScWtCZXNBMzFldWxYRVIwVGpCeEJ1VkdYZTIx?=
 =?utf-8?B?bEgzeHBCVFNUSTVpOFFRQ3k0c0FZMnk5cE5MeFZaTXo4Q1FkYWg2cmk0d0V2?=
 =?utf-8?B?Y0xVT1hKZzZFdDFrUU9Ra1daLyt6TmRJNjNGOFdYc2J2TmRRUWRvNVB6Z3BQ?=
 =?utf-8?B?WnE3dHdlN3dGdzB6KzhvZThTaDdGMUNBYlJxK3JwTUpVYTBNWlRMbDNqbHl3?=
 =?utf-8?B?UUNjdHRXOGFJdkhsb1U1N2FjWHdjN0tZS09ZZXpsUTNtRTNkMGJmSXp4L3hO?=
 =?utf-8?B?Y0d6RitkV0dlY3l3N0lyQmdzNmd6cHc2cE14T2RXUU1KL0lLeFpjTWVEU1pN?=
 =?utf-8?B?RG1idnpmWVVlT1ZtVkNpNU16RVJGSEpRWUFUWjlibVhVN1ZJbm5weHZGMzU0?=
 =?utf-8?B?dDZOUTIzTSs4TG5oMk4yazNtd1kzK1B0c2ZZMHp2bWdPamdWK1pGOUZIOEVV?=
 =?utf-8?B?UTRkWUZ0YmhMKzBkNWhJVzdNWnc3dys1WlQvaTJ5ejVucFdydTNiN3ZsN0Vp?=
 =?utf-8?B?UmZEay9EcEk2blJKT2x4TFVSQldMODkrUFQ0UGhMbTRpMWhxZnhYZWpYR2pK?=
 =?utf-8?B?YjhKTDRrcWpsT3RpZTlqWXN0TkwzMld1QXM2V3JIN0VQdXg1alJYOWMzYTF4?=
 =?utf-8?B?SG44MGJ6cElsTmNEbzBQaytFMGFXSXpPbE9mK0duaHhHZ0o1eGZzRnlwYUl3?=
 =?utf-8?B?ck9odnd0NGxxMy85QWJxQlVGRjJtMHpHZmNjcDhiVGg0bXFwMjN5QnBBUXFR?=
 =?utf-8?B?dm5aZEZZdzBPQU9peTlFeGs4bDVubFNuMEowclBwQzFuckFmVzcyVzdVaVM3?=
 =?utf-8?B?d0dhRmNzTkR3NDhVekNCaGg2RWJDLzZkSmlwL3U0OWpKWk42c2pKSjg1cW1z?=
 =?utf-8?B?aUNGcUhBbVVIQ2pVVitiKyt6M3o2aDMwSkpFQzl5V244UzdjS0lXVG9IcHpt?=
 =?utf-8?B?RVJHY0hEZzBRNGFZdldDUitvMXIyMldpcFQ2NCtsTmlTSUFPaWZMQ0pBU29W?=
 =?utf-8?B?UWFpV0tXbEw1VDBmL2VPdDFIZUxhQVM5MUZ2OC9hSUsyazIvdEZ1RVgrVG41?=
 =?utf-8?B?RVVITEtFdGJtTnFtaWZRK2pGUmtlNmhHSm14S0wyVEFuVmZBeWRpNmlKTlNM?=
 =?utf-8?B?Y3pPa2t5enc0RHhBdXkreGRVbERMckZodE9PeTdBODFxakRaUTU3eWJqUFRk?=
 =?utf-8?B?Q2FwMnhnVTZEQ21rR1N0L21xb0Vxb25xR2hwZ0lWdXErSklTcmsvc1YzU2N0?=
 =?utf-8?B?dVpMK2dzRkdKQVE1b0RhNHZDb2FkdnhCc1JyRFBveFdPaVlRQzRZcWFPd2xn?=
 =?utf-8?B?OFJsdFhvUFp5ckk4Nk5xNlZjR1U3MUFjZ1k0NC96QTB4VU1wUk5NSVZ0VE1V?=
 =?utf-8?B?OTd1aG1CL3VvN3ptWGFHMW15R1pWNEVmeGo3R1U5MEdKMEc5aFRZSmVTaTJv?=
 =?utf-8?B?eU5vNkhBeXkyUGtZR3dmUFE2T0UvMzhKYTNaT2N1M1J6NzB2STVVWituRnMv?=
 =?utf-8?B?OVJqVUJ6aGdUYXNwSEo4aDVXRlJLeUhlc0VPNUVtSWJNTk1LN0RtWEtpSnRk?=
 =?utf-8?B?d0Nla2xRd0REOUFGOVBTRGY5SWI2Q2NJa2xldlZ6RDN4VytEbVRIRUVxcEE4?=
 =?utf-8?B?R2kyejVJc2ZJQXhsenNZeUFJdnlHazdlV0NZK0ZSdTdaK1hjRC9iUkt1TTdZ?=
 =?utf-8?B?dlNuQ0ViSnladU5QL2g4VEo0ZWtlMVVveForL3NOVHlpNzVxM0VpOHpMNXRa?=
 =?utf-8?B?Rjl1MjRYV0syc20va21sdzZ3SHVDNlNUMU05cWNSUS9zeVJqdFpCY1UyUGgv?=
 =?utf-8?B?Tjl2Y3BUWmlEZzJMalRGM2lGZ0JwSzZkNkRUNlZZczBjRzVOK2V5VDlFRi9Y?=
 =?utf-8?B?cXJxNFRDMFYrc0pGRnFzK2J3OXNLZTRVS2tLSDhjL2RlOEpmaXRFTFNoVks2?=
 =?utf-8?B?R1VTRHRyK3hFZjQzQUJhTnVYRnRGaG1qdFNYWExONENPT3ZlOVVGRUxyM2lr?=
 =?utf-8?B?VG5EL2xza0o1NkJVUjJsWnZ4MEkzS0VkZldCajNGQk92STZPUElPT3Rxa2I4?=
 =?utf-8?B?M0x4YURVNWxnZHVtOG1sS1JSbDUzNHd1U1VWazl2c0NvSWJJcDFGSjQzNkFs?=
 =?utf-8?B?OXE2RDBqbXJWUHZrKzBOU2pSMVFRPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8cb527a-359a-4db6-9dd0-08da9d4b5c5c
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2022 10:07:02.6526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: burxypaatZkXUyZQ3qU8rYB+GzOeyudJBPM17TqCLAlArB20e0imAybmESam9iz+RRgbMEcwnGfzxnSkqQWWQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6490
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 19/09/2022 12:25, Akhil R wrote:
> Add dma-channel-mask property in Tegra GPCDMA device tree node.
> 
> The property would help to specify the channels to be used in
> kernel and reserve few for the firmware. This was previously
> achieved by limiting the channel number to 31 in the driver.
> Now since we can list all 32 channels, update the interrupts
> property as well to list all 32 interrupts.
> 
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> ---
>   arch/arm64/boot/dts/nvidia/tegra186.dtsi | 4 +++-
>   arch/arm64/boot/dts/nvidia/tegra194.dtsi | 4 +++-
>   arch/arm64/boot/dts/nvidia/tegra234.dtsi | 4 +++-
>   3 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra186.dtsi b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> index 3580fbf99091..13a84e34e094 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra186.dtsi
> @@ -78,7 +78,8 @@
>   		reg = <0x0 0x2600000 0x0 0x210000>;
>   		resets = <&bpmp TEGRA186_RESET_GPCDMA>;
>   		reset-names = "gpcdma";
> -		interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
> +		interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
>   			     <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
>   			     <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>,
>   			     <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>,
> @@ -112,6 +113,7 @@
>   		#dma-cells = <1>;
>   		iommus = <&smmu TEGRA186_SID_GPCDMA_0>;
>   		dma-coherent;
> +		dma-channel-mask = <0xfffffffe>;
>   		status = "okay";
>   	};
>   
> diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> index 9176c4b27133..593fbf22b34f 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
> @@ -142,7 +142,8 @@
>   			reg = <0x2600000 0x210000>;
>   			resets = <&bpmp TEGRA194_RESET_GPCDMA>;
>   			reset-names = "gpcdma";
> -			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
> +			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
>   				     <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
>   				     <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>,
>   				     <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>,
> @@ -176,6 +177,7 @@
>   			#dma-cells = <1>;
>   			iommus = <&smmu TEGRA194_SID_GPCDMA_0>;
>   			dma-coherent;
> +			dma-channel-mask = <0xfffffffe>;
>   			status = "okay";
>   		};
>   
> diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
> index 5852e765ad90..afd90b72cdea 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
> @@ -28,7 +28,8 @@
>   			reg = <0x2600000 0x210000>;
>   			resets = <&bpmp TEGRA234_RESET_GPCDMA>;
>   			reset-names = "gpcdma";
> -			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
> +			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
>   				     <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
>   				     <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>,
>   				     <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>,
> @@ -61,6 +62,7 @@
>   				     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
>   			#dma-cells = <1>;
>   			iommus = <&smmu_niso0 TEGRA234_SID_GPCDMA>;
> +			dma-channel-mask = <0xfffffffe>;
>   			dma-coherent;
>   		};
>   


Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Thanks!
Jon

-- 
nvpublic
