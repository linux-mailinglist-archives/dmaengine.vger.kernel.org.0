Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311B86F590F
	for <lists+dmaengine@lfdr.de>; Wed,  3 May 2023 15:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjECN1Y (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 3 May 2023 09:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbjECN1X (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 3 May 2023 09:27:23 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B75526B;
        Wed,  3 May 2023 06:27:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y1FF0TBjcdaYbab+fqPJy1F0LDn8Jw0oiMPcoDhVUXWEOPD1M2ALWCTP2tD0giG+jTw9/4asBEND3WukEjWj9RLgzceTWTWQ+UrdRz9Fu5RSoWz0SHZykcM3F/CQOOgI4Qsb6q9MG6st1iwz7TEds5FMs/a2OTXesoAJA/9PcMI7Eq9Hl3hUMLKmiSM029y5e8O+lwqYo8odBPx73ogS0x2dXC5UHX4b2Hz3mgDbg76Wwi97rvWMIuPzCxu0eVFxhafSj99Qdhb4Q8SM5b4Y4UhrJTWNuw/cP2vg+AuPPJwnoLOmljEB/3MU4SsMKG+VaupUlWPP+2++lIrJH8991w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AKfuzJLafCJCtrRt0u9r/wXumyepJe2NtHyXHNE0XBk=;
 b=e+NqCKLEPZbJkGUk+BhEBsE73RZH8Y5Jm0Ggv32WBb2EcWzPmjOYoc68JwRzrbMG9q2Vf/j+iPFp5pG7hPP1kvN+HLnizo4rIAVqf3hl2VXxUXyf5Q8VSfjiLW8li9oYgeiR4UjDi2rTVOfecd0fHJ9ZmdEFJQW8gbS5r5Oa3slBniZKgjT/B+Tc5ujWvD56Rn7G+RFmBr+7M9HKJLNksJtKD0SG734TLg4HoWrvGJl9LzEI9HE7Y1cRPiCKTJZcFhXrUsOyyTQZ5uTIodOZn7X2oNSj7ue41JyQijTp0GmtFZDFO29giNP5nwqw4L8aGGTkR6O0z6rsyyeQx4oanQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKfuzJLafCJCtrRt0u9r/wXumyepJe2NtHyXHNE0XBk=;
 b=DCUKkFNlnNa1HcpTbShZXElHrNX0gWNoV9mDeruEMkgLvmm7w7ITbrseeZpyO/huvny9tBgukcyEKuJI3rUmGcUn176y4FQP58v0I4yspwqokh6+PBwBpdGP7aKtP76BNGa8Ol/UoKwBgWIxcIBnZiQ9S0PBO2uB0xztNtqMstw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by PH0PR12MB8151.namprd12.prod.outlook.com (2603:10b6:510:299::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Wed, 3 May
 2023 13:27:19 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::20b9:d472:1981:cf94]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::20b9:d472:1981:cf94%4]) with mapi id 15.20.6340.031; Wed, 3 May 2023
 13:27:18 +0000
Message-ID: <a5ff9c0f-6ee9-8b1a-5f77-fb56176bce22@amd.com>
Date:   Wed, 3 May 2023 15:27:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <30424f5886ef42419f65c2d5131ad30881c727a4.1683100816.git.michal.simek@amd.com>
 <20230503125125.GE32586@pendragon.ideasonboard.com>
From:   Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH v2] dt-bindings: dma: xilinx: Add power-domains to
 xlnx,zynqmp-dpdma
In-Reply-To: <20230503125125.GE32586@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0117.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::15) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|PH0PR12MB8151:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f4a5ca4-5a66-4ba6-3674-08db4bda1e2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9QMq+rS+u9FVrjDa/oEYWv9m85qxC1u8loAv+uwe44FbXKRes+y7W21iTK8fNSBfMdNn/J427Dfb/QGhFaLaCRxbQBAYRsCt6tE93JUEaTTOPddd+QhPSQn+ZbG0MBBe2ngrr0yQzT5iAyjmX0V3K3/g9Waqiv8WzF4bqP7pE63N1w+gdxQdCMJCIxRgkyOMUcisweMqmvvvg6YXQkoGo4rYl86xkH4M/DZQp9A+5xELr+YRXTkQ5ep7OmcjstRQ5r9EKHOwXuyTMWtZ0AEDjvRm5DDuk+dAtjqVp4X2ArPH86nY9wp44TWS/eSgZhQ9Cv6EqQvBlBkR/dC9UAuvClg11iLu7OPTvoT6KUtrXe0NwtgZvF5J34D8z7/xE1V3A3EY0RrjaEMQaCS7VUfbP2Er//vYEcj4wnTmixo0EM75P+JfvNBj8QXQVe4M9X5LsCwof8qn2zKZKjj1bFICt0ygplfpYPnyt/9sn8FLldIaDHatKFwpA/swvuPasMrjB1rIBLho2FojD0ny11o28pw5YBtsj4aXTksUCGeqvwiNomQvzQPLSHXe9S5AL15Xxqe2xb4YhL209r4W4cJorxn4zTbg3sqNPctoPdndfOvRMG3KRGFDoRzh+F+6vS1vNWoFCjEX4dbr4qWjitZXBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(376002)(136003)(366004)(451199021)(2906002)(478600001)(4744005)(66556008)(66476007)(31686004)(66946007)(5660300002)(8676002)(38100700002)(8936002)(83380400001)(44832011)(7416002)(41300700001)(54906003)(6916009)(316002)(4326008)(6666004)(31696002)(2616005)(6506007)(26005)(36756003)(186003)(86362001)(53546011)(6512007)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmJkLzBLSGJ1UWI5TmN6aDVIQ0R3Zk51NVozK2NmRzVsK2pZOHVyWU1KUC9H?=
 =?utf-8?B?SEZzTlZ0M1ZWQzdJUXRsVHhPL002dkd6QjdjMjZVVE5GQ0t0djYya0o3cE81?=
 =?utf-8?B?ZS9UMldXajVhcGpFVGVFbi90a0h2S2Z6ZGJLUGR5QUxBbkorMzc0d3BpeE5C?=
 =?utf-8?B?bjliQnpoTVpkMTJqK1BNV2V2OFY5QVkwTVFmNzVhN3VJREJXTDFqQ1htdVJX?=
 =?utf-8?B?M2QxaldaU3czdFlwcG9FMlgxNmZ4dmI4U1c2TTZsaHpNWUp2RDhlUmlWS2w0?=
 =?utf-8?B?dmJIRmF1WkJrT1ZGSHYyREFacjlTeFdqZ2ZFYklCNG5wTnlmM2QrSEREYWJF?=
 =?utf-8?B?d214ZDQwekZkaURCbkZ6TU15akRaTmdwdFBiYjVaSUJvZEF2T3hBdEczS2pu?=
 =?utf-8?B?TlBrbHl2TEVlYVRqZjgwbGNjMmF6dU56eGV3MysyeEJxVUNLZjlGU0NJUk5S?=
 =?utf-8?B?dzlaMCtkZlh2d0lmNU1oR2pzL1lsNnRjYkdnLzZneUR1M2tJYzR1Y2FwT1VL?=
 =?utf-8?B?TEtQV2JLWVUyNzROeE8vSzZEeDdqbVB0UkhlMTJPYTdjbmo1NU5ZSk9SeWVT?=
 =?utf-8?B?Lzh4V1dwVkVjeVFLWkVhRi9kSTc1cXV0bnRoa2U0ODJoNE5xUDhXSDAyUVVx?=
 =?utf-8?B?eDF4eEhaZ1R4NG1weVQxOENncXg3dCtwNHdTdXRCVFhpSVg0MTViRVVpVkpm?=
 =?utf-8?B?MGF0S25uSTZJT3YyNXdOK1ZRc3pGRGNVeE1Dc0ZwejZQakxCekR6blZxNTB4?=
 =?utf-8?B?UzFlZEh3Skx2bXg5alY3cC9ocjNMMTRVYS9XMWpWYnRxa3IrdWhqOVp5RWJI?=
 =?utf-8?B?WE00UTlOTlRSN3RoTGdIalM5N0w5S1ZidmE2L2ZRY1Fmb1FoRjJEU1lUNWcx?=
 =?utf-8?B?SnFyMzhRbnZSaGNhWXBoZlVGVTlrelFqdVdlTlp4VHJBVGhhcWZGUlV1RkFD?=
 =?utf-8?B?RUJVRjV2a0E0MjducGszR2h3T2xybTc1bm5UQ2V1aElQM0dsYVE5TUJ4ZitE?=
 =?utf-8?B?THdzUGtNMmRxb1Y4cUpxa2VLZE0wdGl3STEyRDEyekdWSWtab2RhRS9jQjN6?=
 =?utf-8?B?WE5CVVBPOTUvUzhJNkhZUGdObFFQQkI0NzlpSHJZOTZxbDh4aDRFZkM2c3lE?=
 =?utf-8?B?RGl2aGlPUWNwOUpmVVhTUE44aFZacFZwd0pEZUVqTmc3TjQyckRyNzV3bkpa?=
 =?utf-8?B?ZDdZb1ZPMHZkUjdTcVJzMEQ2WFdZME5ERERGd2ZsdEwveFZ2VXE1NDFMdmpo?=
 =?utf-8?B?QW05S2lKV3RZdmw4MjNjak4yVWdYbXFFNTNFSDVmWVNVNDMyZjRjTmxzSmFr?=
 =?utf-8?B?V2hOWXRGSjAva3gyN0pTR2R6RzZld2hXd1ZvZkRFTFY3eHBkaVFDQTZ1OGZF?=
 =?utf-8?B?b3MvZGlTRHl6Tk5NejhvYzM4bW5samM5eENhOTRNZGJESlZaNU1vVkpaaGxq?=
 =?utf-8?B?T1FJODJGTEtYaTUreHBvaWpjSmZSY2xrMWJnNmZ3M1JNYmZ5SmpVWWlkYk0r?=
 =?utf-8?B?QnBPY0R2N2NPVlhySTNPTmMvNC9TOUpQOTdDaTZNdVZzNGJhSzM1K3l4SDVq?=
 =?utf-8?B?Q1BPRGhLVzNYZjh0bHJWb29xRDdJY1daSFFnK1psZVEvVE1kYmVnQU92UjZU?=
 =?utf-8?B?OU4yWW4wMmhEZzQxNm1lc0dET0cxOFdyT3o2dWdRZEZHbVZWNmZDTXRoTFRj?=
 =?utf-8?B?QnNJemVVcWR1Nkl3NGh1dXpBZ2lNVDRrSGU4alVBdGZDcjlIdlBScEI1VWZi?=
 =?utf-8?B?KzhFWnBuTDVZdTZ5OUhvRTF2SXhSN3VRS2hmWFNubW9zU2JUbHdLRUI3YUxs?=
 =?utf-8?B?azFvcC9iRHVuWk16UGFERzFZQXlJMjd6L25TcElBQnFYVk9NMzIySC9wam5K?=
 =?utf-8?B?Mi9XT0YzZk40bWdCTENPeExLclZGQXpqZGtKT0M1NmxSMURpVGQzNTY3ZkJt?=
 =?utf-8?B?elhuZG9YdkhvNzlLcWc4bkFYNHl6TTJpelpXencwUzVUcHh0UHN6NitDQm5q?=
 =?utf-8?B?SlVTdng2SUxWa3UwckEwV3A4ZTBjdTVSVVVMYjdVN1IrM20vRHNnSUFQWjQ3?=
 =?utf-8?B?MUJ6eXJLMGFQbGhOWjlFL0x5MGFHaWdzZFh6ekdiY3NkQUhmS0E1cVFjZEpG?=
 =?utf-8?Q?bu54msCDNtXrINPw771k6Lotd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f4a5ca4-5a66-4ba6-3674-08db4bda1e2e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 13:27:18.5818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yuTXoqUC3KaQMSWXPFhzNF1896hZebfvNHGwLTgLxv9YzGPByau2WxnaWRJSa2WO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8151
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

On 5/3/23 14:51, Laurent Pinchart wrote:
> Hi Michal,
> 
> Thank you for the patch.
> 
> On Wed, May 03, 2023 at 10:00:20AM +0200, Michal Simek wrote:
>> DP DMA has own power domain that's why describe optional power-domain
>> property.
> 
> As far as I understand, the property should always be specified, the
> only reason why it's not mandatory is backward-compatibility (I would
> make it mandatory, as I think proper validation of new DT is more
> important than avoiding breaking validation - but not operation! - of
> old DT, but that's a separate story). If my understanding is correct,
> could you please update the example in the bindings to add the
> power-domains property ?

backward compatible - of course
always specified - if pd driver is enabled it must be there. If not it doesn't 
do anything - just describes it.

I am not in a position to decide this. But if dt folks agree with your ask I am 
happy to make it mandatory and extend example.

M

