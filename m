Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69BD36A78E5
	for <lists+dmaengine@lfdr.de>; Thu,  2 Mar 2023 02:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjCBBg7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 1 Mar 2023 20:36:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCBBg6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 1 Mar 2023 20:36:58 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43C93347A;
        Wed,  1 Mar 2023 17:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677721016; x=1709257016;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ieiymo+u4ftU4eBbAcMS4HN7w7wxh+e2uXkqxRpeWGo=;
  b=lVyWmGZKQbvWNjhPX4FzCb14sCic23O9OmbQyvIPdqpzEDWfSa05kIoF
   M+b0yX47zfMoOzKLrYtfgi4UGBV/TnDe9n2wf8hR9oDzAALU/hbUm3e9J
   Srt7140Odieq/npGLOQzskEqa5HFDGSbt7GRE/s+pHv09SmN+ebZaxfvQ
   hJIrrNBffyxJZhfL8f/b+zH7n+02ZbB+//R9zb4lRiKpI3NAdkJ9hMihj
   jdGrbf/R1fA6Vm0FaCh1C4KeMXQWZtAFKb7ja+WaegBEoH26eY2gYr1A3
   dotrRl6DXn+PPVKU1/usHUmyKxQO2J4zqkiV1mv8i4y6e/pIeV7+GLvYy
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="322855183"
X-IronPort-AV: E=Sophos;i="5.98,226,1673942400"; 
   d="scan'208";a="322855183"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 17:36:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="676992376"
X-IronPort-AV: E=Sophos;i="5.98,226,1673942400"; 
   d="scan'208";a="676992376"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 01 Mar 2023 17:36:55 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 1 Mar 2023 17:36:52 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 1 Mar 2023 17:36:52 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 1 Mar 2023 17:36:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nFoVzvLGC+1mlvWyaejBPsg3Evdb92IEf1dFconyrCjLpf/VRw8Du4ht1ufH6fudRqLCjhIiM/jc5iXTaZ/Yaglc+xebvHADyNycKSY0Q7oas4ubcCd2tcYm4KChPcEDTQDsrvEnoEdeLSLUWbGVHumzBaPm7gz0IZhyL07XtDcvtVGI1xFFZEGInY16s3IgKsYQjjSICidulimNdS7EwBl6VuFhMwp2biAlVYoVTWkR1GJgC10W+NiFtoIt0DFJPpl6rhYoAwijUZU0ZZpVv7aHoqbQxH4FbATetUQ9qv5jjbNmClHwmJiYmsa3Fw8Nr6as0lMuUqcZFyp0ch22bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=osnIjiijnDcDpB6d3CfiZW7/Q4xAtDY+gu9zgD0S4Dc=;
 b=UsEp2O/ru39WNwc+R+bYyAuxxboReUnygECFY+XQNumSbSyOGp7BFVJyJAztXImW2pQn9wrl9wFwwMyfxyKrsaRGhBwACUkA1lJaghqgAQkw17CTWeGwi7uWGQZQ7aodrukRrXXzlijmxHV17yasIbD/CLYko2aO0QDRATlJsHALlBYJr0JXjOAKaL9apGCO01hrKx6oJx5am42+LphzNbj6QiSPkKscTCbbhCalJHC03MHRmZkqLbZM+Fur0vYWDVD4xPGxi8zABuvNXWRD1j7zwGN+em6DTLPCqucmOAp5UF7S+I2TQYeOFlGrGVaXU6MdAwYMqUu7iaV6sGOLOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by PH0PR11MB5641.namprd11.prod.outlook.com (2603:10b6:510:d6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Thu, 2 Mar
 2023 01:36:48 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::726b:a43a:2100:7171]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::726b:a43a:2100:7171%9]) with mapi id 15.20.6156.017; Thu, 2 Mar 2023
 01:36:48 +0000
Message-ID: <8700d72f-a995-8ab5-45a5-cc08e34e57f6@intel.com>
Date:   Wed, 1 Mar 2023 17:36:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v4 5/6] iommu/ioasid: Rename INVALID_IOASID
Content-Language: en-US
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "X86 Kernel" <x86@kernel.org>, <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, <corbet@lwn.net>,
        <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
CC:     Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
        "David Woodhouse" <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>
References: <20230301235646.2692846-1-jacob.jun.pan@linux.intel.com>
 <20230301235646.2692846-6-jacob.jun.pan@linux.intel.com>
From:   Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20230301235646.2692846-6-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::23) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|PH0PR11MB5641:EE_
X-MS-Office365-Filtering-Correlation-Id: 4008490c-af4b-4efe-4ab9-08db1abe96fb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FWziLaiARDoYXiXYy8LZ7/FjeHpX3XPBqCfKeo/pRQE9TajL+S7Sq57yoRohrPGdTpLjnsAsDWRXV3z6aCvMMPpu0GwlYMkMjxlFf6imrFVW1AclxpVIjkmF8B76/HEtr+x0iDTyI8AeP/CDl+MdKrtatldkqF8Xz1GgpyxQSAGSQfSwlWPR+qQc/BYA3LOfVcZsqTDyNWo603CcSwgf5e23kAuYiB5TA0MceDMzzOJPrAxMmu33LwlEnS2tn/3qlJ1ZNd0Ob++1yibKzyKyR600sEVp9+zEflnKUJkj4QH8RsK1Tl4q6l3K09HU3rQEt1lVu6uAJ3haT5plrBN11Q3dp/QokD0b4cCiGSjiMre1FDVTuMihU876hxgEhlfRNBQSKpwknJ0CNs9nTTRQ6kf37KsBPXXBiQeBkxNNPPzHB4lgcXIwNf00N5EYVPA0h2yKp2DTOLVPq0dJ90IZ+i8TcXYa9PXmOEpHsr9nMl1Wx/SIMhiKkin8br25HVPkZ7mQrk84yPXoiyHhPaApLOZtG4h+pHkBVUrwDj8YX0lGlp5WqCiIPjEgofPHpl/L9F2qAprwkxfbuhd4gcJ2Gc5xqF/NmdV84vl9/HU39RGozNYm+qMb0KwK9sMXEAilp3gUjLY0u9dRsZbx3Jdo9GXMg1cIh6uS3RbkifMG/JGrXEiAL0j5U2a2jOGxVhPzPqIX6V87iuZX4FzIFMZi5Sdg0VsvBxFIWmP79d+HPgTdJ0qZmQbSQKPphv0Kl+Yc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(366004)(39860400002)(396003)(346002)(451199018)(36756003)(6666004)(53546011)(6486002)(6506007)(6512007)(2616005)(186003)(26005)(316002)(110136005)(54906003)(41300700001)(4326008)(66476007)(66556008)(44832011)(4744005)(2906002)(8676002)(8936002)(5660300002)(478600001)(7416002)(82960400001)(38100700002)(31696002)(86362001)(66946007)(921005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHBpdStmYVhPQjd1cldWM0NEVnpaVzF5aGRnRHNGR0pCWGlpUy8xTHE4cTUy?=
 =?utf-8?B?bVFtQks1MTJ3NEsyRjA0UE5uSUVvMTNUcmkya0VXTnlUVjlkaDdFTkp3WU54?=
 =?utf-8?B?UXJOcTI4N2VzaUU2SkRWb0RnYlhXN3RzbEJhdGFydFVOSGZ1ZTFvb0NvU2pP?=
 =?utf-8?B?VXhPYmhSSjRVTS9wUjZKU0JSN25JdWJYdzhIdmZhU05MQlZicW9UanB6RlY5?=
 =?utf-8?B?cnI1alpuM25KQWtjRUJRb1A5ejByN3BZT3o1ZXFGSGZ1YktYTEFPL0tVSGYy?=
 =?utf-8?B?VUphbWFlQVFZTnNvbU82d3I4T3g0U1d6YTNuWHhKZ0hoZjYzZzIxQkVwZmk1?=
 =?utf-8?B?NUZtYityRUhCSGpnZTVnQ3ZwRXhrYTVDU3ZqelB3UHJEVVQ2dThESkkwNXRZ?=
 =?utf-8?B?VEdaZHp0Rk5Ga1lnMXJDN0VSNU1lcktZY0VCOVh2UDdDTjlZNUsyWVhjcnZG?=
 =?utf-8?B?QWVnbU1qTkpkWEpwbHFDZ2hGZkhHdmsrTXg4bjZleVo1N0VMWXJ0MUxXYmdp?=
 =?utf-8?B?ZUJhQkNnV0pLMDg0amNKQVlXU0JvZGlPZHNEQW12Z1phK0F5L1pUV0diWHpv?=
 =?utf-8?B?TE1wOUprVm9iMXFBdXc3WE45VStHVmNFOE5jWGZNQ2doTGpTL0JYdGVmYllJ?=
 =?utf-8?B?MnJMVDlDRWxOT3lMZCtCSDVWTElPdys4N3RDZmY5bXBVY25BYnd5YnNsVWJh?=
 =?utf-8?B?NnlqeGdBWUQ3cytDRnU0OVJDWnlkanFLZlI4ODQzS2dZaXRhVGk2eGYvTHRM?=
 =?utf-8?B?c2NTc00zS25CVGEvUy9nMG5lU0ZjQWd3TGNtUTIzcHQ1TktZMWkrU3FSVTFH?=
 =?utf-8?B?N0hwbUVyL2c5VzMxemRWaTgvNEdnVjRtRGpVR3dxREhhbWhyMm1jUnJRbzJr?=
 =?utf-8?B?Y3N0TVF1ZUJQNGVMUWU5aEhWM0QyUU91N0pDMzFhM2JnZncybHlMMWZRdnNw?=
 =?utf-8?B?dXM2bHBLdmlJb2dnZk9ER0dqRFBidkpiQzhISkpPbmwzdzd4cHNXZmFTQjRS?=
 =?utf-8?B?NmxZN05ZR0pMTFFrUklkMnVkQmZ1T2YrM2loWEZpNzNNejBJN3RwS1l4WFFS?=
 =?utf-8?B?RmZ0S1pmdENPQ0JzTGpTek42ZXUrZUxTelhrRjhiaTFkK09GZCtSOHJoS2ZI?=
 =?utf-8?B?OWtTM3R5cnlkWUdSL2ZZYWNjN3RnY0dKQldCeE03azQ0bnVCcnFjalBPaDBr?=
 =?utf-8?B?eUwvS0k4a0ZBMjltQjNpQlRIY0VxVkRLMDg4cnAvRGpFK3pESUZCZVBtVDJL?=
 =?utf-8?B?YjBaci9KWE0zTCtWRURuRlJZeC9kb1A1TTRNM2s1cUVvbEpjcnhsVXpPTnpS?=
 =?utf-8?B?Z3VDMjg3bHBUUzQvSWx0dmpHTnhoVm1BREtZNnRqRFl5ZTRYaUVMdFQydUM3?=
 =?utf-8?B?K21CUVU4RHdzeDVtanZkMitQaHYzK3NDUkl6MWFmdFdycWVnT1dYbHFEeVNQ?=
 =?utf-8?B?MGdycXdLNlY5eDlKc3FTdXpsUHZraWY5aytkc0o0cVQyWGJpcEwwQzRJRG9k?=
 =?utf-8?B?WmJjYlZncnNtSU5LS2U1MnRram5saFM0YjFtNEs1Yk1aeFprL2IxNFA2YnRu?=
 =?utf-8?B?cFEwbHQ4VjJaMXI2SXJkTWt5bnNOQkNyR1ZzZmpmT2dwQ1B3MTVLaEhqZTJE?=
 =?utf-8?B?WjJFdEJaQTd3NGl3ajFZY3k2YUZ5Ni9uOWFhYnlwZWZNZ3pkTEYwV0xNZjdW?=
 =?utf-8?B?U0phcGVDOFZsTkMrdDlRdU92QXZVS1dDNVRKVWgxdFVpMlJjMWFxVG96KzFv?=
 =?utf-8?B?S1ByNXVGK2hjWW1YKzBMUzFLV3pxa1FVRFBpOTdRajVDQWg5N3pScElwKzNC?=
 =?utf-8?B?RUFmdEJySTMwZFc5aXBkN1Zva3FkY1ltTk1ES1FCVXJzS2NQS1A2ck1LcTVB?=
 =?utf-8?B?ZTJYWWZVRTNaejg0dUVjWjNnRFpoSkEvUGZMOXhmdkhGK2JEZTAwTlRmblI3?=
 =?utf-8?B?T0RvaUhubjdIZXYrdDd6M0NTenB0SnpLVVhFN3YwS01NbGdDZGlzOE4xOEor?=
 =?utf-8?B?dS93YXFxU2k1ZndoeXRFby82VFI0QmlHdjNmdmxEQVlDbE9MNEhNS0VNYllB?=
 =?utf-8?B?N0hOY2s5c2duWm1VWEVTclVIM0dTTTNyN1plVWhidFRXUUVQY2U5V0ZtSjls?=
 =?utf-8?Q?knyruYgbvNrkRrRrzRoq5zgd4?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4008490c-af4b-4efe-4ab9-08db1abe96fb
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 01:36:48.5965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GAvc0kf1lTQpWyWoIQ6oJQxMlUuRi3sUcOU3WIGahbhunI2/KbdvWKuGHhX8HRx3VXAjp1U4biBH83BDGnJclw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5641
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 3/1/23 15:56, Jacob Pan wrote:
> INVALID_IOASID and IOMMU_PASID_INVALID are duplicated. Rename
> INVALID_IOASID and consolidate since we are moving away from IOASID
> infrastructure.
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>

Thanks.

-Fenghua
